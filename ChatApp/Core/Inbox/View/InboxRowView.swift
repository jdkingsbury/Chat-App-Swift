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
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            CircularProfileImageView(user: message.user, size: .small)
            
            VStack(alignment: .leading, spacing: 4) {

                Text(message.user?.username ?? "")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Text(message.messageText)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(2)
                    .frame(maxWidth: UIScreen.main.bounds.width - 100, alignment: .leading)
            }
            
            Text(message.timestampString)
            .font(.footnote)
            .foregroundColor(.gray)
        }
        .frame(height: 72)
    }
}
