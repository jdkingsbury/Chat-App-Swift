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
    @State private var isInitialLoad = false
    
    @StateObject var viewModel: ChatViewModel
    
    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: ChatViewModel(user: user))
    }
    
    static let emptyScrollToString = "Empty"
    
    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.messages.indices, id: \.self) { index in
                            ChatMessageCell(message: viewModel.messages[index], nextMessage: viewModel.nextMessage(forIndex: index))
                                .id(viewModel.messages[index].id)
                        }
                    }
                }
                .onChange(of: viewModel.messages) { newValue in
                    guard let lastMessage = newValue.last else { return }
                    
                    withAnimation(.spring()) {
                        proxy.scrollTo(lastMessage.id)
                    }
                }
            }
            
            Spacer()
            
            // message input view
            MessageInputView(messageText: $messageText, viewModel: viewModel)
        }
        .onDisappear {
            viewModel.removeChatListener()
        }
        .onChange(of: viewModel.messages) { _ in
            Task { try await viewModel.updateMessageStatusIfNecessary() }
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
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(user: User.MOCK_USERS[0])
    }
}
