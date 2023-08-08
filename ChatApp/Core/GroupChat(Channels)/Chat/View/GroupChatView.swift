//
//  GroupChatView.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 7/23/23.
//

import SwiftUI

struct GroupChatView: View {
    let user: User
    @StateObject var viewModel: GroupChatViewModel
    
    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: GroupChatViewModel(user: user))
    }
    
    var body: some View {
        VStack {
            ScrollView {
                ScrollViewReader { ScrollViewProxy in
                    // header
                    VStack {
                        CircularProfileImageView(user: User.MOCK_USERS[0], size: .xLarge)

                        VStack(spacing: 4){
                            Text(User.MOCK_USERS[0].username)
                                .font(.title3)
                                .fontWeight(.semibold)

                            Text("Messanger")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    // placeholder for messages
                    
                    ForEach((0 ... 10), id: \.self) { _ in
                        GroupChatCell(isFromCurrentUser: true, messageText: "Group Chat")
                    }
                }
            }
            
            Spacer()
            
            // message input view
            ZStack(alignment: .trailing) {
                TextField("Message...", text: $viewModel.messageText, axis: .vertical)
                    .padding(12)
                    .padding(.trailing, 48)
                    .background(Color(.systemGroupedBackground))
                    .clipShape(Capsule())
                    .font(.subheadline)
                
                Button {
                        viewModel.sendMessage()
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

struct GroupChatView_Previews: PreviewProvider {
    static var previews: some View {
        GroupChatView(user: User.MOCK_USERS[0])
    }
}
