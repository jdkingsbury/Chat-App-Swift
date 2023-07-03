//
//  ProfileView.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 7/2/23.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @StateObject var profileViewModel = ProfileViewModel()
    
    var body: some View {
        if let user = viewModel.currentUser {
            VStack {
                // header
                VStack {
                    Text(user.initials)
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 72, height: 72)
                        .background(Color(.systemGray))
                        .clipShape(Circle())
                    
    //                PhotosPickerItem(selection: $viewModel.selectedItem) {
    //                    if let profileImage = viewModel.profileImage {
    //                        profileImage
    //                            .resizable()
    //                            .scaledToFill()
    //                            .frame(width: 80, height: 80)
    //                            .clipShape(Circle())
    //                    } else {
    //                        Image(user.profileImageUrl ?? "")
    //                            .resizable()
    //                            .scaledToFill()
    //                            .frame(width: 80, height: 80)
    //                            .clipShape(Circle())
    //                    }
    //                }
                    
                    Text(user.fullname)
                        .font(.title2)
                        .fontWeight(.semibold)
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
                        Button("Log Out") {
                            viewModel.signOut()
                        }
                        Button("Delete Account") {
                            
                        }
                    }
                    .foregroundColor(.red)
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
