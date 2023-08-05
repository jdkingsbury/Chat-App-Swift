//
//  InboxView.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 7/2/23.
//

import SwiftUI

struct InboxView: View {
    
    @StateObject var viewModel = InboxViewModel()
    
    @State var selectedUser: User?
    @State private var showNewMessageView = false
    @State private var showChat = false
    
    private var user: User? { return viewModel.currentUser }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                List {
                    ForEach(viewModel.recentMessages) { recentMessage in
                        ZStack {
                            NavigationLink(value: recentMessage){
                                EmptyView()
                            } .opacity(0.0)
                            
                            InboxRowView(message: recentMessage)
                        }
                    }
                }
                .navigationTitle("Chats")
                .navigationBarTitleDisplayMode(.inline)
                .listStyle(PlainListStyle())
                .frame(height: UIScreen.main.bounds.height - 120)
            }
            .onChange(of: selectedUser, perform: { newValue in
                showChat = newValue != nil
            })
            .navigationDestination(for: Message.self, destination: { message in
                if let user = message.user {
                    ChatView(user: user)
                }
            })
            .navigationDestination(for: User.self, destination: { user in
                ProfileView(user: user)
                    .navigationBarBackButtonHidden()
            })
            .navigationDestination(isPresented: $showChat, destination: {
                if let user = selectedUser {
                    ChatView(user: user)
                }
            })
            .fullScreenCover(isPresented: $showNewMessageView, content: {
                NewMessageView(show: $showNewMessageView, selectedUser: $selectedUser)
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        NavigationLink(value: user)
                        {
                            CircularProfileImageView(user: user, size: .small)
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showNewMessageView.toggle()
                        selectedUser = nil
                    } label: {
                        Image(systemName: "square.and.pencil.circle.fill")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundStyle(.black, Color(.systemGray5))
                    }
                    
                }
            }
        }
    }
}

//struct InboxView_Previews: PreviewProvider {
//    static var previews: some View {
//        InboxView(user: User.MOCK_USERS[0])
//    }
//}
