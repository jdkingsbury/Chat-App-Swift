//
//  InboxRowView.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 7/2/23.
//

import SwiftUI
import Firebase

struct InboxRowView: View {
//    private let user: User
//    let message: Message
    @ObservedObject var viewModel: InboxRowViewModel
    
    var body: some View {
        if let user = viewModel.message.user {
            NavigationLink(destination: ChatView(user: user)) {
                HStack(alignment: .top, spacing: 12) {
                    CircularProfileImageView(user: viewModel.message.user, size: .medium)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        
                        
                        Text(viewModel.username)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        
                        Text(viewModel.message.text)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .lineLimit(2)
                            .frame(maxWidth: UIScreen.main.bounds.width - 100, alignment: .leading)
                    }
                    
                    Text("\(viewModel.message.timestamp)")
                    .font(.footnote)
                    .foregroundColor(.gray)
                }
                .frame(height: 72)
            }
        }
    }
}

//struct InboxRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        InboxRowView(user: User.MOCK_USERS[0], messageText: "Test Message", timestamp: Date())
//    }
//}
