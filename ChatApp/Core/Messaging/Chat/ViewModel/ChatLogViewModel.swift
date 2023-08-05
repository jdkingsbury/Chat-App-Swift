//
//  ChatLogViewModel.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 7/14/23.
//

import SwiftUI
import Firebase

class ChatLogViewModel: ObservableObject {
    @Published var messages = [Message]()
    @Published var messageText = ""
    @Published var count = 0
    
    let user: User
    
    init(user: User) {
        self.user = user
        observeMessages()
    }
    
    func observeMessages() {
        MessageService.observeMessages(chatPartner: user) { messages in
            self.messages.append(contentsOf: messages)
        }
        
        DispatchQueue.main.async {
            self.count += 1
        }
    }
    
    
    @MainActor
    func sendMessage() {
        MessageService.sendMessage(messageText, toUser: user)
    }
    
}
