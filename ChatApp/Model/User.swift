//
//  User.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 7/2/23.
//

import Foundation

struct User: Codable, Identifiable, Hashable {
    var id = NSUUID().uuidString
    let fullname: String
    let email: String
    var profileImageUrl: String?
    
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
    static let MOCK_USER = User(fullname: "Michael Jordan", email: "batman@gmail.com", profileImageUrl: "batman")
}
