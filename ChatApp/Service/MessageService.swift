//
//  MessageService.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 7/13/23.
//

import Firebase

struct MessageService {
    static func updateMessageStatusIfNecessary(_ messages: [Message]) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let lastMessage = messages.last, !lastMessage.read else { return }
        
        try await FirestoreConstants.MessagesCollection
            .document(uid)
            .collection("recent-messages")
            .document(lastMessage.id)
            .updateData(["read": true])
    }
}
