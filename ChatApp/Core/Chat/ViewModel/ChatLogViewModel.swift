//
//  ChatLogViewModel.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 7/14/23.
//

import SwiftUI
import Firebase

class ChatLogViewModel: ObservableObject {
    @Published var messages = [Message]()
    @Published var messageText = ""
    @Published var count = 0
    
    
    private let user: User?
    
    init(user: User?) {
        self.user = user
        Task { try await fetchMessages() }
    }
    
    var firestoreListener: ListenerRegistration?
    
    func fetchMessages() async throws {
        firestoreListener?.remove()
        
        guard let currentUserId = await AuthService.shared.userSession?.uid else { return }
        
        guard let chatPartnerId = user?.id else { return }
        
        firestoreListener = COLLECTION_MESSAGES
            .document(currentUserId)
            .collection(chatPartnerId)
            .order(by: "timestamp")
            .addSnapshotListener({ querySnapshot, error in
            if let error = error {
                print("DEBUG: Failed to listen to messages with error \(error.localizedDescription)")
                return
            }
            
            querySnapshot?.documentChanges.forEach({ change in
                if change.type == .added {
                    if let message = try? change.document.data(as: Message.self) {
                        self.messages.append(message)
                    }
                }
            })
            
            DispatchQueue.main.async {
                self.count += 1
            }
            
        })
    }
    
    
    @MainActor
    func sendMessage() async {
        
        guard let currentUserId = AuthService.shared.userSession?.uid else { return }
        
        guard let chatPartnerId = user?.id else { return }
        
        let currentUserRef = COLLECTION_MESSAGES.document(currentUserId).collection(chatPartnerId).document()
        let chatPartnerRef = COLLECTION_MESSAGES.document(chatPartnerId).collection(currentUserId)
        
        let messageId = currentUserRef.documentID
        
        let recentCurrentRef = COLLECTION_MESSAGES.document(currentUserId).collection("recent-messages").document(chatPartnerId)
        
        let recentPartnerRef = COLLECTION_MESSAGES.document(chatPartnerId).collection("recent-messages").document(currentUserId)
        
        
        
        let data: [String: Any] = [FirebaseConstants.text: self.messageText,
                                   FirebaseConstants.fromId: currentUserId,
                                   FirebaseConstants.toId: chatPartnerId,
                                   FirebaseConstants.read: false,
                                   FirebaseConstants.timestamp: Timestamp(date: Date())]
        
        self.messageText = ""
        self.count += 1
        
        try? await currentUserRef.setData(data)
        try? await chatPartnerRef.document(messageId).setData(data)
        
        try? await recentCurrentRef.setData(data)
        try? await recentPartnerRef.setData(data)
        
    }
    
}
