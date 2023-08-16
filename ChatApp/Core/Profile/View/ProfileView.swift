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
                    ZStack(alignment: .bottomTrailing) {
                        if let profileImage = viewModel.profileImage {
                            profileImage
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                        } else {
                            CircularProfileImageView(user: viewModel.user, size: .xLarge)
                        }
                        
                        ZStack {
                            Circle()
                                .fill(Color.theme.background)
                                .frame(width: 24, height: 24)
                            
                            Image(systemName: "camera.circle.fill")
                                .foregroundStyle(Color.theme.primaryText, Color(.systemGray5))
                                .frame(width: 18, height: 18)
                        }
                    }
                }
                
                Text(viewModel.user.fullname)
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(systemName: "chevron.left.circle.fill")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundStyle(Color.theme.primaryText, Color.theme.secondaryBackground)
                        .onTapGesture {
                            Task {
                                dismiss()
                            }
                        }
                }
            }
            
            // list
            List {
                Section {
                    ForEach(SettingsOptionsViewModel.allCases) {viewModel in
                        ProfileRowView(viewModel: viewModel)
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
