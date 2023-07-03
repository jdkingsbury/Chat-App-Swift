//
//  InputView.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 7/2/23.
//

import SwiftUI

struct InputView: View {
    @Binding var text: String
    
    let title: String
    let placeholder: String
    var isSecureField = false
    
    var body: some View {
        VStack {
            
            if isSecureField {
                SecureField(placeholder, text: $text)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
            } else {
                TextField(placeholder, text: $text)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
            }
                
        }
    }
    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 12) {
//            Text(title)
//                .foregroundColor(Color(.darkGray))
//                .fontWeight(.semibold)
//                .font(.footnote)
//
//            if isSecureField {
//                SecureField(placeholder, text: $text)
//                    .font(.system(size: 14))
//            } else {
//                TextField(placeholder, text: $text)
//                    .font(.system(size: 14))
//            }
//
//            Divider()
//        }
//    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView(text: .constant(""), title: "Email Address", placeholder: "name@example.com")
    }
}
