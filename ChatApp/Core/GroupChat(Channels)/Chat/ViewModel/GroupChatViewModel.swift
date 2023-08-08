//
//  GroupChatViewModel.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 8/7/23.
//

import SwiftUI
import Firebase

class GroupChatViewModel: ObservableObject {
    
    
    @Published var messages = [Message]()
    @Published var messageText = ""
    @Published var count = 0
    
    let user: User
    
    init(user: User) {
        self.user = user
        observeMessages()
    }
    
    // fetch group chat messages
    func observeMessages() {
//        ChatService.observeMessages(chatPartner: user) { messages in
//            self.messages.append(contentsOf: messages)
//        }
        
    }
    
    // send group chat message
    @MainActor
    func sendMessage() {
//        ChatService.sendMessage(messageText, toUser: user)
    }
    
}
