//
//  ChatView.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 7/11/23.
//

import SwiftUI

struct ChatView: View {
    let user: User
    
    @StateObject var viewModel: ChatLogViewModel
    
    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: ChatLogViewModel(user: user))
    }
    
    static let emptyScrollToString = "Empty"
    
    var body: some View {
        VStack {
            ScrollView {
                ScrollViewReader { ScrollViewProxy in
                    Spacer()
                    
                    // messages
                    LazyVStack {
                        ForEach(viewModel.messages) { message in
                            ChatMessageCell(message: message)
                        }
                        .id(Self.emptyScrollToString)
                        .onReceive(viewModel.$count) { _ in
                            withAnimation(.easeOut(duration: 0.5)) {
                                ScrollViewProxy.scrollTo(Self.emptyScrollToString, anchor: .bottom)
                            }
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem (placement: .principal) {
                    HStack {
                        CircularProfileImageView(user: user, size: .xxSmall)
                        
                        Text(user.username)
                            .font(.title3)
                            .fontWeight(.semibold)
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
                    viewModel.messageText = ""
                    viewModel.count += 1
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
