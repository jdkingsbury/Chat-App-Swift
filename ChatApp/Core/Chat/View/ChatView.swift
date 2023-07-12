//
//  ChatView.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 7/11/23.
//

import SwiftUI

struct ChatView: View {
    let user: User
    
    @State private var messageText = ""
    @StateObject var viewModel: ChatViewModel
    
    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: ChatViewModel(user: user))
    }
    
    
    var body: some View {
        VStack {
            
            ScrollView {
                // header
                VStack {
                    CircularProfileImageView(user: user, size: .xLarge)
                    
                    VStack(spacing: 4){
                        Text(user.username)
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Text("Messanger")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
                
                // messages
            }
            
            Spacer()
            
            // message input view
            
            ZStack(alignment: .trailing) {
                TextField("Message...", text: $messageText, axis: .vertical)
                    .padding(12)
                    .padding(.trailing, 48)
                    .background(Color(.systemGroupedBackground))
                    .clipShape(Capsule())
                    .font(.subheadline)
                
                Button {
                    Task {
                        try await viewModel.sendMessage(_: messageText)
                        messageText = ""
                    }
                } label: {
                    Text("Send")
                        .fontWeight(.semibold)
                }
                .padding(.horizontal)
                
            }
            .padding()
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(user: User.MOCK_USERS[0])
    }
}
