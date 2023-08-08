//
//  AuthViewModel.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 7/2/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestoreSwift
import Firebase

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

@MainActor
class AuthService: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    static let shared = AuthService()
    
    init() {
        self.userSession = Auth.auth().currentUser
        Task { try await loadCurrentUserData() }
    }
    
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            try await loadCurrentUserData()
        } catch {
            print("DEBUG: Failed to log in with error \(error.localizedDescription)")
            throw error
        }
    }
    
    @MainActor
    func createUser(email: String, password: String, username: String, fullname: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            try await uploadUserData(uid: result.user.uid, username: username, email: email, fullname: fullname)
            try await loadCurrentUserData()
        } catch {
            print("DEBUG: Failed to register user with error \(error.localizedDescription)")
            throw error
        }
    }
    
    private func loadCurrentUserData() async throws {
        Task { try await UserService.shared.fetchCurrentUser() }
    }
    
    func signout() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            UserService.shared.currentUser = nil
            InboxService.shared.reset()
        } catch {
            print("DEBUG: failed to signout")
        }
    }
    
    func deleteAccount() {
        print("Delete account...")
    }
    
    private func uploadUserData(uid: String, username: String, email: String, fullname: String) async throws {
        let user = User(uid: uid, username: username, fullname: fullname, email: email)
        self.currentUser = user
        guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
        try? await COLLECTION_USERS.document(user.id).setData(encodedUser)
    }
}
