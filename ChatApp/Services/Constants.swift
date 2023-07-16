//
//  Constants.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 7/11/23.
//

import Firebase

let COLLECTION_USERS = Firestore.firestore().collection("users")

let COLLECTION_MESSAGES = Firestore.firestore().collection("messages")


struct FirebaseConstants {
    static let id =  "id"
    static let fromId = "fromId"
    static let toId = "toId"
    static let read = "read"
    static let text = "text"
    static let timestamp = "timestamp"
    static let username = "username"
}
