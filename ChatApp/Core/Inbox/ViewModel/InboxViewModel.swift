//
//  InboxViewModel.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 7/16/23.
//

import SwiftUI

class InboxViewModel: ObservableObject {
    let user: User
    
    @Published var messages = [Message]()
    @Published var messageToSetVisible: String?
    
    init(user: User) {
        self.user = user
        Task { await fetchRecentMessages() }
    }
    
    @MainActor
    func fetchRecentMessages() {
        guard let currentUid = AuthService.shared.userSession?.uid else { return }
        let uid = user.id
                
        let query = COLLECTION_MESSAGES
            .document(currentUid)
            .collection(uid)
            .order(by: "timestamp", descending: false)
        
        query.addSnapshotListener { snapshot, error in
            guard let changes = snapshot?.documentChanges.filter({ $0.type == .added }) else { return }
            let messages = changes.compactMap({ try? $0.document.data(as: Message.self) })
            
            self.messages.append(contentsOf: messages)
                        
            for (index, message) in self.messages.enumerated() where message.fromId != currentUid {
                self.messages[index].user = self.user
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.messageToSetVisible = self.messages.last?.id
                }
            }
        }
    }
}

