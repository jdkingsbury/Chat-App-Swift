//
//  InboxViewModel.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 7/16/23.
//

import SwiftUI

class InboxViewModel: ObservableObject {
    let user: User
    
    @Published var recentMessages = [Message]()
    @Published var messageToSetVisible: String?
    
    init(user: User) {
        self.user = user
        Task { await fetchRecentMessages() }
    }
    
    @MainActor
    func fetchRecentMessages() {
        guard let currentUid = AuthService.shared.userSession?.uid else { return }
//        let uid = user.id
                
        let query = COLLECTION_MESSAGES
            .document(currentUid)
            .collection("recent-messages")
            .order(by: "timestamp", descending: false)
        
        query.addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("DEBUG: Failed to listen to messages with error \(error.localizedDescription)")
                return
            }
            
            querySnapshot?.documentChanges.forEach({ change in
                if change.type == .added {
                    let docId = change.document.documentID
                    self.recentMessages.append(.init(documentId: docId, data: change.document.data()))
                }
            })
        }
    }
}

