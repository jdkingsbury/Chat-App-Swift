//
//  MessageViewModel.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 7/20/23.
//

import Foundation

class ChatMessageViewModel: ObservableObject {
    let message: Message
    
    init(_ message: Message) {
        self.message = message
    }
    
    @MainActor
    var currentUid: String {
        return AuthService.shared.userSession?.uid ?? ""
    }
    
    @MainActor
    var isFromCurrentUser: Bool {
        return message.fromId == currentUid
    }
    
}
