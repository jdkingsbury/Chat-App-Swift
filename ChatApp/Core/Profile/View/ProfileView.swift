//
//  ProfileView.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 7/2/23.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @StateObject var viewModel: ProfileViewModel
    @Environment(\.dismiss) var dismiss
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: ProfileViewModel(user: user))
    }
    
    var body: some View {
        VStack {
            // header
            VStack {
                
                PhotosPicker(selection: $viewModel.selectedImage) {
                    if let profileImage = viewModel.profileImage {
                        profileImage
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                    } else {
                        CircularProfileImageView(user: viewModel.user, size: .xLarge)
                    }
                }
                
                Text(viewModel.user.fullname)
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(systemName: "chevron.left")
                        .imageScale(.large)
                        .onTapGesture {
                            Task {
                                dismiss()
                            }
                        }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        Task {
                            try await viewModel.updateUserData()
                            dismiss()
                        }
                    } label: {
                        Text("Save")
                            .font(.subheadline)
                            .fontWeight(.bold)
                    }
                }
            }
            
            // list
            
            List {
                Section {
                    ForEach(SettingsOptionsViewModel.allCases) {option in
                        HStack {
                            Image(systemName: option.imageName)
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(option.imageBackgroundColor)
                            
                            Text(option.title)
                                .font(.subheadline)
                        }
                    }
                }
                
                Section {
                    Button("Sign Out") {
                        AuthService.shared.signout()
                    }
                    Button("Delete Account") {
                        
                    }
                }
                .foregroundColor(.red)
            }
            
            
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User.MOCK_USERS[0])
    }
}
