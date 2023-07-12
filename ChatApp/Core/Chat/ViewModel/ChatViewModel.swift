//
//  ChatViewModel.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 7/11/23.
//

import SwiftUI
import Firebase

class ChatViewModel: ObservableObject {
    @Published var messages = [Message]()
    
    let user: User

    init(user: User) {
        self.user = user
    }

    
    func sendMessage(_ messageText: String) async throws {
        guard let currentUid = await AuthService.shared.userSession?.uid else { return }
        let chatPartnerId = user.id
        let currentUserRef = COLLECTION_MESSAGES.document(currentUid).collection(chatPartnerId).document()
        let chatPartnerRef = COLLECTION_MESSAGES.document(chatPartnerId).collection(currentUid)
        
        let messageId = currentUserRef.documentID
        
        let data: [String: Any] = ["text": messageText,
                                   "fromId": currentUid,
                                   "toId": chatPartnerId,
                                   "read": false,
                                   "timestamp": Timestamp(date: Date())]
        
        try await currentUserRef.setData(data)
        try await chatPartnerRef.document(messageId).setData(data)
    }
}

import Foundation
