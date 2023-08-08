//
//  SelectGroupMembersView.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 7/24/23.
//

import SwiftUI

struct SelectGroupMembersView: View {
    @State private var searchText = ""
    @State private var groupName = ""
    
    @Binding var show: Bool
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel = SelectGroupMembersViewModel()
    
    var filteredUsers: [SelectableUser] {
        guard !searchText.isEmpty else { return viewModel.selectableUsers }
        return viewModel.selectableUsers.filter {
            $0.user.fullname.localizedCaseInsensitiveContains(searchText) ||
            $0.user.username.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                // user list view
                ScrollView {
                    // Selected users view
                    if !viewModel.selectedUsers.isEmpty {
                        SelectedGroupMembersView(viewModel: viewModel)
                    }
                    
                    Text("CONTACTS")
                        .foregroundColor(.gray)
                        .font(.footnote)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    
                    ForEach(filteredUsers) { selectableUser in
                        VStack {
                            Button {
                                viewModel.selectUser(selectableUser, isSelected: !selectableUser.isSelected)
                            } label: {
                                SelectableUserCell(viewModel: SelectableUserCellViewModel(selectableUser: selectableUser))
                            }
                            
                            Divider()
                                .padding(.leading, 40)

                        }
                    }
                    .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
                    
                    
                }
                .navigationTitle("New group")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Back") {
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink {
                            CreateGroupChatView(viewModel.selectedUsers, show: $show)
                                .navigationBarBackButtonHidden()
                        } label: {
                            Text("Next")
                            
                        }
                    }
                }
                .foregroundColor(Color.theme.primaryText)
            }
        }
    }
}

