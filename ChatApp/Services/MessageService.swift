//
//  MessageService.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 7/13/23.
//

import Firebase

struct MessageService {
    
    private static let messageCollection = Firestore.firestore().collection("messages")
    
    static func fetchUserConversations(uid: String) async throws -> [Message] {
        let snapshot = try await messageCollection.whereField("ownerUid", isEqualTo: uid).getDocuments()
        return try snapshot.documents.compactMap({ try $0.data(as: Message.self) })
    }
}
