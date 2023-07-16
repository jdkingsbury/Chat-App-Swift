//
//  InboxRowView.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 7/2/23.
//

import SwiftUI

struct InboxRowView: View {
    let user: User
    let messageText: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            CircularProfileImageView(user: user, size: .medium)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(user.username)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Text(messageText)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(2)
                    .frame(maxWidth: UIScreen.main.bounds.width - 100, alignment: .leading)
            }
            
            HStack {
                Text("Yesterday")
                
                Image(systemName: "chevron.right")
            }
            .font(.footnote)
            .foregroundColor(.gray)
        }
        .frame(height: 72)
    }
}

struct InboxRowView_Previews: PreviewProvider {
    static var previews: some View {
        InboxRowView(user: User.MOCK_USERS[0], messageText: "Test Message")
    }
}
