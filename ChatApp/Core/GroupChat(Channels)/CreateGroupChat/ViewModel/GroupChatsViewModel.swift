//
//  GroupChatsViewModel.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 8/1/23.
//

import Foundation

class GroupChatsViewModel: ObservableObject {
    @Published var grouChats = [GroupChat]()
    
    init() {
        Task { await fetchGroupChats() }
    }
    
    @MainActor
    func fetchGroupChats() async {
        guard let uid = AuthService.shared.userSession?.uid else { return }
        
        COLLECTION_GROUP_MESSAGES.whereField("uids", arrayContains: uid).getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            self.grouChats = documents.compactMap({ try? $0.data(as: GroupChat.self) })
        }
    }
}
