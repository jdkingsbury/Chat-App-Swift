//
//  GroupChat.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 8/1/23.
//

import FirebaseFirestoreSwift
import Firebase

struct GroupChat: Codable, Identifiable, Hashable {
    @DocumentID var messageId: String?
    let groupName: String
    let imageUrl: String?
    let fromId: String
    let uids: [String]
    let messageText: String
    let timestamp: Timestamp
    
    var id: String {
        return messageId ?? NSUUID().uuidString
    }
}
