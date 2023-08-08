//
//  CreateChannelViewModel.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 7/25/23.
//

import Firebase
import SwiftUI
import PhotosUI

@MainActor
class CreateGroupChatViewModel: ObservableObject {
    let users: [User]
    
    init(_ selectableUsers: [SelectableUser]) {
        self.users = selectableUsers.map({ $0.user })
    }
    
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task { await loadImage(fromItem: selectedImage) } }
    }
    
    @Published var groupChatImage: Image?
    
    private var uiImage: UIImage?
    
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else { return }
                
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.groupChatImage = Image(uiImage: uiImage)

    }
    
    func createGroupChat(name: String) async {
        guard let currentUser = AuthService.shared.currentUser else { return }
        let currentUid = currentUser.id
        
        var uids = users.compactMap({ $0.id })
        uids.append(currentUid)
        
        var data: [String: Any] = ["name": name,
                                   "uids": uids,
                                   "lastMessage": "\(currentUser.username) started a group chat"]
        
        if let uiImage = uiImage {
            let imageUrl = try? await ImageUploader.uploadImage(image: uiImage, type: .group)
            data["groupChatImageUrl"] = imageUrl
        }
        
        try? await COLLECTION_GROUP_MESSAGES.document().setData(data)
    }
}
