//
//  InboxViewModel.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 7/16/23.
//

import SwiftUI
import Firebase

class InboxViewModel: ObservableObject {
    @Published var recentMessages = [Message]()
    @Published var messageToSetVisible: String?
    
    init() {
        Task { try await fetchRecentMessages() }
    }
    
    private var firestoreListener: ListenerRegistration?
    
    @MainActor
    func fetchRecentMessages() async throws {
        guard let currentUid = AuthService.shared.userSession?.uid else { return }
        
        firestoreListener?.remove()
        self.recentMessages.removeAll()
                
        firestoreListener = COLLECTION_MESSAGES
            .document(currentUid)
            .collection("recent-messages")
            .order(by: "timestamp", descending: false)
            .addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("DEBUG: Failed to listen to messages with error \(error.localizedDescription)")
                return
            }
            
            querySnapshot?.documentChanges.forEach({ change in
                let docId = change.document.documentID
                
                if let index = self.recentMessages.firstIndex(where: { recentMessage in
                    return recentMessage.id == docId
                }) {
                    self.recentMessages.remove(at: index)
                }
                
                if let recentMessage = try? change.document.data(as: Message.self) {
                    self.recentMessages.insert(recentMessage, at: 0)
                }

                
            })
        }
    }
    
}

