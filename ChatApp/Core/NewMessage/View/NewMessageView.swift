//
//  NewMessageView.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 7/2/23.
//

import SwiftUI

struct NewMessageView: View {
    @State private var searchText = ""
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel = NewMessageViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                TextField("To: ", text: $searchText)
                    .frame(height: 44)
                    .padding(.leading)
                    .background(Color(.systemGroupedBackground))
                
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
            }
            .navigationDestination(for: User.self, destination: { user in
                ChatView(user: user)
            })
            .navigationTitle("New Message")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.black)
                }
            }
        }
    }
}

struct NewMessageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            NewMessageView()
        }
    }
}
