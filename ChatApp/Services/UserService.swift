//
//  UserService.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 7/11/23.
//

import Foundation
import Firebase

struct UserService {
    
    static func fetchUser(withUid uid: String) async throws -> User {
        let snapshot = try await COLLECTION_USERS.document(uid).getDocument()
        return try snapshot.data(as: User.self)
    }
    
    static func fetchAllUsers() async throws -> [User] {
        let snapshot = try await COLLECTION_USERS.getDocuments()
        return snapshot.documents.compactMap({ try? $0.data(as: User.self) })
    }
}
