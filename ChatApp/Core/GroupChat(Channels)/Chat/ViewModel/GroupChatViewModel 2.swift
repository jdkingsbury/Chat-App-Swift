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
        MessageService.observeMessages(chatPartner: user) { messages in
            self.messages.append(contentsOf: messages)
        }
        
        DispatchQueue.main.async {
            self.count += 1
        }
    }
    
    // send group chat message
    @MainActor
    func sendMessage() {
        MessageService.sendMessage(messageText, toUser: user)
    }
    
}
