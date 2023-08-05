//
//  Message.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 7/11/23.
//

import FirebaseFirestoreSwift
import Firebase

struct Message: Codable, Identifiable, Hashable {
    @DocumentID var messageId: String?
    let fromId: String
    let toId: String
    let read: Bool
    let messageText: String
    let timestamp: Timestamp
    
    
    var user: User?
    
    var id: String {
        return messageId ?? NSUUID().uuidString
    }
    
    var chatPartnerId: String {
        return fromId == Auth.auth().currentUser?.uid ? toId : fromId
    }
    
    var isFromCurrentUser: Bool {
        return fromId == Auth.auth().currentUser?.uid
    }
    
    var timestampString: String {
        return timestamp.dateValue().timestampString()
    }
    
}
