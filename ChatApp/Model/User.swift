//
//  User.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 7/2/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct User: Codable, Identifiable, Hashable {
    
    @DocumentID var uid: String?
    var username: String
    var profileImageUrl: String?
    var fullname: String
    let email: String
    
    var id: String {
        return uid ?? NSUUID().uuidString
    }
    
    var isCurrentUser: Bool {
        guard let currentUid = Auth.auth().currentUser?.uid else { return false }
        return currentUid == uid
    }
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullname) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        
        return ""
    }
}

extension User {
    static var MOCK_USERS: [User] = [
        .init(uid: NSUUID().uuidString, username: "batman", profileImageUrl: nil, fullname: "Bruce Wayne", email: "batman@gmail.com"),
        .init(uid: NSUUID().uuidString, username: "venom", profileImageUrl: nil, fullname: "Eddie Brock", email: "venom@gmail.com"),
        .init(uid: NSUUID().uuidString, username: "ironman", profileImageUrl: nil, fullname: "Tony Start", email: "ironman@gmail.com"),
        .init(uid: NSUUID().uuidString, username: "spiderman", profileImageUrl: nil, fullname: "Peter Parker", email: "spiderman@gmail.com"),
    ]
}
