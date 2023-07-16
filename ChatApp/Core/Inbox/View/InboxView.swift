//
//  InboxView.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 7/2/23.
//

import SwiftUI

struct InboxView: View {
    let user: User
    @State private var showNewMessageView = false
    @ObservedObject var viewModel: InboxViewModel
    
    init(user: User) {
        self.user = user
        self.viewModel = InboxViewModel(user: user)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                List {
                    ForEach(viewModel.messages) { message in
                        InboxRowView(user: user, messageText: message.text)
                    }
                }
                .listStyle(PlainListStyle())
                .frame(height: UIScreen.main.bounds.height - 120)
                 
            }
            .navigationDestination(for: User.self, destination: { user in
                ProfileView(user: user)
                    .navigationBarBackButtonHidden()
            })
            .fullScreenCover(isPresented: $showNewMessageView, content: {
                NewMessageView()
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        NavigationLink(value: user)
                        {
                            CircularProfileImageView(user: user, size: .small)
                        }
                        Text("Chats")
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showNewMessageView.toggle()
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

struct InboxView_Previews: PreviewProvider {
    static var previews: some View {
        InboxView(user: User.MOCK_USERS[0])
    }
}
