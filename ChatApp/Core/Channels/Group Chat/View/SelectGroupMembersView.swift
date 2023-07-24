//
//  SelectGroupMembersView.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 7/24/23.
//

import SwiftUI

struct SelectGroupMembersView: View {
    @State private var searchText = ""
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel = NewMessageViewModel()
    
    var body: some View {
        VStack {
            // user list view
            ScrollView {
                
                // Selected users view
                SelectedGroupMembersView()
                
                Text("CONTACTS")
                    .foregroundColor(.gray)
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                ForEach(viewModel.users) { user in
                    
                    VStack {
                        NavigationLink(value: user) {
                            HStack {
                                CircularProfileImageView(user: user, size: .small)
                                
                                Text(user.username)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                
                                Spacer()
                            }
                            .foregroundColor(.black)
                            .padding(.leading)
                        }
                        
                        
                        Divider()
                            .padding(.leading, 40)
                    }
                }
                .searchable(text: $searchText, prompt: "Search...")
            }
            .navigationDestination(for: User.self, destination: { user in
                ChatView(user: user)
            })
            .navigationTitle("New group")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.black)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Next") {
                        print("Destination")
                    }
                    .foregroundColor(.black)
                }
            }
        }
    }
}

struct SelectGroupMembersView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SelectGroupMembersView()
        }
    }
}
