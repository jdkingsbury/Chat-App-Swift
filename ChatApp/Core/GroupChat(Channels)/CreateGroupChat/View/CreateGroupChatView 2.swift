//
//  CreateGroupChatView.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 7/26/23.
//

import SwiftUI
import PhotosUI

struct CreateGroupChatView: View {
    @State private var groupName = ""
    @StateObject var viewModel: CreateGroupChatViewModel
    @Environment(\.dismiss) var dismiss
    @Binding var show: Bool
    
    init(_ selectableUsers: [SelectableUser], show: Binding<Bool>) {
        self._viewModel = StateObject(wrappedValue: CreateGroupChatViewModel(selectableUsers))
        self._show = show
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack(spacing: 32) {
                PhotosPicker(selection: $viewModel.selectedImage) {
                    if let groupChatImage = viewModel.groupChatImage {
                        groupChatImage
                            .resizable()
                            .scaledToFill()
                            .frame(width: 64, height: 64)
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 64, height: 64)
                            .foregroundColor(Color.theme.secondaryBackground)
                            .clipShape(Circle())
                    }
                }
                .padding(.leading)
                
                VStack(alignment: .leading, spacing: 12) {
                    
                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundColor(Color.theme.secondaryBackground)
                    
                    TextField("Enter group name", text: $groupName)
                        .foregroundColor(Color.theme.primaryText)
                    
                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundColor(Color.theme.secondaryBackground)
                }
                .padding()
            }
            
            Spacer()
        }
        .navigationTitle("Create Group")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Back") {
                    dismiss()
                }
                .foregroundColor(Color.theme.primaryText)
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Create") {
                    Task { await viewModel.createGroupChat(name: groupName) }
                    show.toggle()
                }
                .disabled(groupName.isEmpty)
                .foregroundColor(Color.theme.primaryText)
            }
        }
    }
}
