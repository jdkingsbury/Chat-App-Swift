//
//  ChatMessageCell.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 7/11/23.
//

import SwiftUI
import Firebase
import Kingfisher

struct ChatMessageCell: View {
    let message: Message
    var nextMessage: Message?
    
    init(message: Message, nextMessage: Message?) {
        self.message = message
        self.nextMessage = nextMessage
    }
    
    private var isFromCurrentUser: Bool {
        return message.isFromCurrentUser
    }
    
    private var shouldShowChatPartnerImage: Bool {
        if nextMessage == nil && !message.isFromCurrentUser { return true }
        guard let next = nextMessage else { return message.isFromCurrentUser }
        return next.isFromCurrentUser
    }
    
    var body: some View {
        HStack {
            if isFromCurrentUser {
                Spacer()
                
                if let imageUrl = message.imageUrl {
                    MessageImageView(imageUrlString: imageUrl)
                } else {
                    Text(message.messageText)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemBlue))
                        .foregroundColor(.white)
                        .clipShape(ChatBubble(isFromCurrentUser: isFromCurrentUser))
                        .padding(.horizontal)
                        .frame(maxWidth: UIScreen.main.bounds.width / 1.5, alignment: .trailing)
                }
                
            } else {
                HStack(alignment: .bottom, spacing: 8) {
                    if shouldShowChatPartnerImage {
                        CircularProfileImageView(user: message.user, size: .xxSmall)
                    }
                    
                    if let imageUrl = message.imageUrl {
                        MessageImageView(imageUrlString: imageUrl)

                    } else {
                        Text(message.messageText)
                            .font(.subheadline)
                            .padding(12)
                            .background(Color(.systemGray6))
                            .foregroundColor(Color.theme.primaryText)
                            .clipShape(ChatBubble(isFromCurrentUser: isFromCurrentUser))
                            .frame(maxWidth: UIScreen.main.bounds.width / 1.75, alignment: .leading)
                            .padding(.leading, shouldShowChatPartnerImage ? 0 : 32)
                    }
                    
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 8)
    }
}

struct MessageImageView: View {
    let imageUrlString: String
    
    var body: some View {
        KFImage(URL(string: imageUrlString))
            .resizable()
            .scaledToFill()
            .clipped()
            .frame(maxWidth: UIScreen.main.bounds.width / 1.5, maxHeight: 400)
            .cornerRadius(10)
            .padding(.trailing)
    }
}

//struct ChatMessageCell_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatMessageCell(isFromCurrentUser: false, messageText: "Test Message")
//    }
//}
