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
        
<<<<<<< HEAD
        try await FirestoreConstants.MessagesCollection
=======
        try await COLLECTION_MESSAGES
>>>>>>> testing
            .document(uid)
            .collection("recent-messages")
            .document(lastMessage.id)
            .updateData(["read": true])
    }
}

