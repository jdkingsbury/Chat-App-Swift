//
//  NewMessageView.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 7/2/23.
//

import SwiftUI

struct NewMessageView: View {
    @State private var searchText = ""
    @ObservedObject var viewModel = NewMessageViewModel()
    
    @Binding var show: Bool
    @Binding var selectedUser: User?
    
    var filteredUsers: [User] {
        guard !searchText.isEmpty else { return viewModel.users }
        return viewModel.users.filter { $0.fullname.localizedCaseInsensitiveContains(searchText) ||
                                        $0.username.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                TextField("To: ", text: $searchText)
                    .frame(height: 44)
                    .padding(.leading)
                    .background(Color(.systemGroupedBackground))
                
                VStack {
                    HStack {
                        NavigationLink {
                            SelectGroupMembersView(show: $show)
                                .navigationBarBackButtonHidden()
                        } label: {
                            ZStack {
                                Image(systemName: "circle.fill")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                                    .foregroundColor(Color(.systemGray6))
                                
                                Image(systemName: "person.3.fill")
                                    .resizable()
                                    .frame(width: 25, height: 18)
                                    .foregroundColor(Color(.black))
                            }
                            
                            Text("Create a new group")
                                .fontWeight(.semibold)
                                .font(.subheadline)
                        }
                        
                        Spacer()
                    }
                    .foregroundColor(.black)
                    .padding(.leading)
                }
                
                Text("CONTACTS")
                    .foregroundColor(.gray)
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                ForEach(filteredUsers) { user in
                    VStack {
                        HStack {
                            CircularProfileImageView(user: user, size: .small)

                            Text(user.username)
                                .font(.subheadline)
                                .fontWeight(.semibold)

                            Spacer()
                        }
                        .foregroundColor(.black)
                        .padding(.leading)

                        
                        Divider()
                            .padding(.leading, 40)
                    }
                    .onTapGesture {
                        selectedUser = user
                        show.toggle()
                    }
                }
            }
            .navigationTitle("New Message")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        show.toggle()
                    }
                    .foregroundColor(.black)
                }
            }
        }
    }
}

