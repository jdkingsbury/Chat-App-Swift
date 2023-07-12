//
//  NewMessageViewModel.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 7/11/23.
//

import SwiftUI
import Firebase

class NewMessageViewModel: ObservableObject {
    @Published var users = [User]()
    
    init() {
        Task { try await fetchAllUsers() }
    }
    
    @MainActor
    func fetchAllUsers() async throws {
        self.users = try await UserService.fetchAllUsers()
            .filter({ $0.id != AuthService.shared.userSession?.uid })
    }
}

