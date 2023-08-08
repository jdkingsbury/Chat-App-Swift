//
//  InboxRowView.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 7/2/23.
//

import SwiftUI
import Firebase

struct InboxRowView: View {
    let message: Message
    @ObservedObject var viewModel: InboxViewModel
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            
            HStack {
                if !message.read && !message.isFromCurrentUser {
                    Circle()
                        .fill(Color(.systemBlue))
                        .frame(width: 6, height: 6, alignment: .leading)
                }
                
                CircularProfileImageView(user: message.user, size: .medium)
            }
            
            VStack(alignment: .leading, spacing: 4) {

                if let user = message.user {
                    Text(user.fullname)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.theme.primaryText)
                }
                
                Text("\(message.isFromCurrentUser ? "You: \(message.messageText)" : message.messageText)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(2)
                    .frame(maxWidth: UIScreen.main.bounds.width - 100, alignment: .leading)
            }
            
            HStack {
                Text(message.timestampString)
                .font(.footnote)
                .foregroundColor(.gray)
                
                Image(systemName: "chevron.right")
            }
            .font(.footnote)
            .foregroundColor(.gray)
        }
        .frame(height: 72)
        .swipeActions {
            withAnimation(.spring()) {
                Button {
                    Task { try await viewModel.deleteMessage(message) }
                } label: {
                    Image(systemName: "trash")
                }
                .tint(Color(.systemRed))
            }
        }
    }
}
