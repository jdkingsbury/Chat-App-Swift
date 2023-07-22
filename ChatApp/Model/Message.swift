//
//  Message.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 7/11/23.
//

import FirebaseFirestoreSwift
import Firebase

struct Message: Codable, Identifiable, Hashable {
    @DocumentID var id:     String?
    let fromId:             String
    let toId:               String
    let read:               Bool
    let text:               String
    let timestamp:          Date
    var user:               User?
    
}
