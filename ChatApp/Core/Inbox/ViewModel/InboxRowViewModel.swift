//
//  InboxRowViewModel.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 7/22/23.
//

import Foundation

class InboxRowViewModel: ObservableObject {
    @Published var message: Message
    
    init(_ message: Message) {
        self.message = message
        Task { try? await fetchUser() }
    }
    
    @MainActor
    var chatPartnerId: String {
        return message.fromId == AuthService.shared.userSession?.uid ? message.toId : message.fromId
    }
    
    var username: String {
        guard let user = message.user else { return "" }
        return user.username
    }
    
    @MainActor
    func fetchUser() async throws {
        self.message.user = try await UserService.fetchUser(withUid: chatPartnerId)
    }
}
