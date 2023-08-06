//
//  NewInboxViewModel.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 8/3/23.
//

import Foundation
import Combine
import Firebase

class InboxViewModel: ObservableObject {
    @Published var currentUser: User?
    @Published var recentMessages = [Message]()
    
    private var cancellables = Set<AnyCancellable>()
    private let service = InboxService()
    private var didCompleteInitialLoad = false
    
    init() {
        setupSubscribers()
        service.observeRecentMessages()
    }
    
    private func setupSubscribers() {
        UserService.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
        }.store(in: &cancellables)
        
        service.$documentChanges.sink { [weak self] changes in
            guard let self else { return }
            if !self.didCompleteInitialLoad {
                self.loadInitialMessages(fromChanges: changes)
            } else {
                self.updateMessages(fromChanges: changes)
            }
        }.store(in: &cancellables)
    }
    
    private func loadInitialMessages(fromChanges changes: [DocumentChange]) {
        var messages = changes.compactMap({ try? $0.document.data(as: Message.self) })
        
        for i in 0 ..< messages.count {
            let message = messages[i]
            
            UserService.fetchUser(withUid: message.chatPartnerId) { user in
                messages[i].user = user
                self.recentMessages.append(messages[i])
                
                if i == messages.count - 1 {
                    self.didCompleteInitialLoad = true
                }
            }
        }
    }
    
    private func updateMessages(fromChanges changes: [DocumentChange]) {
        for change in changes {
            if change.type == .added {
                self.createNewConversation(fromChange: change)
            } else if change.type == .modified {
                self.updateMessagesFromExisitingConversation(fromChange: change)
            }
        }
    }
    
    private func createNewConversation(fromChange change: DocumentChange) {
        guard var message = try? change.document.data(as: Message.self) else { return }
        
        UserService.fetchUser(withUid: message.chatPartnerId) { user in
            message.user = user
            self.recentMessages.insert(message, at: 0)
        }
    }
    
    private func updateMessagesFromExisitingConversation(fromChange change: DocumentChange) {
        guard var message = try? change.document.data(as: Message.self) else { return }
        guard let index = self.recentMessages.firstIndex(where: {
            $0.user?.id ?? "" == message.chatPartnerId
        }) else { return }
        guard let user = self.recentMessages[index].user else { return }
        message.user = user
        
        self.recentMessages.remove(at: index)
        self.recentMessages.insert(message, at: 0)
    }
}
