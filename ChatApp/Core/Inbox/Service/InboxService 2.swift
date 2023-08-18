//
//  InboxService.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 8/3/23.
//

import Foundation
import Firebase

class InboxService {
    @Published var documentChanges = [DocumentChange]()
    
    static let shared = InboxService()
    
    private var firestoreListener: ListenerRegistration?
    
    func observeRecentMessages() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let query = COLLECTION_MESSAGES
            .document(uid)
            .collection(FirebaseConstants.recentMessages)
            .order(by: "timestamp", descending: true)
        
        self.firestoreListener = query.addSnapshotListener { snapshot, _ in
            guard let changes = snapshot?.documentChanges.filter({
                $0.type == .added || $0.type == .modified
            }) else { return }
            
            self.documentChanges = changes
        }
    }
    
    static func deleteMessage(_ message: Message) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let chatPartnerId = message.chatPartnerId
        
        let snapshot = try await COLLECTION_MESSAGES.document(uid).collection(chatPartnerId).getDocuments()
        
        await withThrowingTaskGroup(of: Void.self, body: { group in
            for doc in snapshot.documents {
                group.addTask {
                    try await COLLECTION_MESSAGES
                        .document(uid)
                        .collection(chatPartnerId)
                        .document(doc.documentID)
                        .delete()
                }
            }
            
            group.addTask {
                try await COLLECTION_MESSAGES
                    .document(uid)
                    .collection("recent-messages")
                    .document(chatPartnerId)
                    .delete()
            }
            
        })
    }
    
    func reset() {
        self.firestoreListener?.remove()
        self.firestoreListener = nil
        self.documentChanges.removeAll()
    }
}
