//
//  SelectGroupMembersViewModel.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 7/25/23.
//

import Foundation

class SelectGroupMembersViewModel: ObservableObject {
    @Published var selectableUsers = [SelectableUser]()
    @Published var selectedUsers = [SelectableUser]()
    
    init() {
        Task { try await fetchUsers() }
    }
    
    // fetching users
    @MainActor
    func fetchUsers() async throws {
        let snapshot = try await COLLECTION_USERS.getDocuments()
        let getUsers = snapshot.documents.compactMap({ try? $0.data(as: User.self) })
            .filter({ $0.id != AuthService.shared.userSession?.uid })

        self.selectableUsers = getUsers.map({ SelectableUser(user: $0) })
    }
    
    // select/ deselect users
    
    func selectUser(_ user: SelectableUser, isSelected: Bool) {
        guard let index = selectableUsers.firstIndex(where: { $0.id == user.id }) else { return }
        
        selectableUsers[index].isSelected = isSelected
        
        if isSelected {
            selectedUsers.append(selectableUsers[index])
        } else {
            selectedUsers.removeAll(where: { $0.id == user.id })
        }
    }
}
