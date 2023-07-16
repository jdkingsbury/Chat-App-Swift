//
//  Message.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 7/11/23.
//

import FirebaseFirestoreSwift
import Firebase

struct Message: Codable, Identifiable, Hashable {
    var id:         String { documentId }
    let fromId:     String
    let toId:       String
    let read:       Bool
    let text:       String
    let timestamp:  Timestamp
    let documentId: String
    var user:       User?
    
    init(documentId: String, data: [String: Any]) {
        self.documentId = documentId
        self.fromId = data[FirebaseConstants.fromId] as? String ?? ""
        self.toId = data[FirebaseConstants.toId] as? String ?? ""
        self.read = false
        self.text = data[FirebaseConstants.text] as? String ?? ""
        self.timestamp = data[FirebaseConstants.timestamp] as? Timestamp ?? Timestamp(date: Date())
    }
    
    
}
