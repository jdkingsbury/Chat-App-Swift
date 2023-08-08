//
//  ProfileViewModel.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 7/11/23.
//

import PhotosUI
import Firebase
import SwiftUI

@MainActor
class ProfileViewModel: ObservableObject {
    @Published var user: User
    
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task { try await loadImage() } }
    }
    
    @Published var profileImage: Image?
    
    init(user: User) {
        self.user = user
    }
    
    @MainActor
    func loadImage() async throws {
        guard let uiImage = try await PhotosPickerHelper.loadImage(fromItem: selectedImage) else { return }
        profileImage = Image(uiImage: uiImage)
        try await updateUserProfileImage(uiImage)
    }
    
    func updateUserProfileImage(_ uiImage: UIImage) async throws {
        guard let imageUrl = try? await ImageUploader.uploadImage(image: uiImage, type: .profile) else { return }
        try await UserService.shared.updateUserProfileImageUrl(imageUrl)
    }
    
}

