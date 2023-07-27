//
//  SelectableUserCell.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 7/24/23.
//

import SwiftUI

struct SelectableUserCell: View {
    let viewModel: SelectableUserCellViewModel
    
    var body: some View {
        VStack {
            HStack {
                CircularProfileImageView(user: viewModel.selectableUser.user, size: .small)
                
                Text(viewModel.username)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Image(systemName: viewModel.selectedImageName)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(viewModel.selectedImageForegroundColor)
                    .frame(width: 20, height: 20)
                    .padding(.trailing)
            }
            .foregroundColor(.black)
            .padding(.leading)
        }
    }
}
