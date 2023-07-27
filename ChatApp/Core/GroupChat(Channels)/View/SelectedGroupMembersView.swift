//
//  SelectedGroupMembersView.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 7/24/23.
//

import SwiftUI

struct SelectedGroupMembersView: View {
    @ObservedObject var viewModel: SelectGroupMembersViewModel
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(viewModel.selectedUsers) { selectableUser in
                    ZStack(alignment: .topTrailing) {
                        VStack {
                            CircularProfileImageView(user: selectableUser.user, size: .medium)
                            
                            Text(selectableUser.user.fullname)
                                .font(.system(size: 11))
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: 64)
                        
                        Button {
                            viewModel.selectUser(selectableUser, isSelected: false)
                        } label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 10, height: 10)
                                .padding(4)
                        }
                        .background(Color(.systemGray6))
                        .foregroundColor(.black)
                        .clipShape(Circle())

                        
                    }
                }
            }
        }
        .animation(.spring(), value: 0.5)
        .padding()
    }
}
