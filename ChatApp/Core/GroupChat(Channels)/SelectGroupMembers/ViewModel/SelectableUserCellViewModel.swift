//
//  SelectableUserCellViewModel.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 7/25/23.
//

import SwiftUI

struct SelectableUserCellViewModel {
    let selectableUser: SelectableUser
    
    var username: String {
        return selectableUser.user.username
    }
    
    var fullname: String {
        return selectableUser.user.fullname
    }
    
    var selectedImageName: String {
        return selectableUser.isSelected ? "checkmark.circle.fill" : "circle"
    }
    
    var selectedImageForegroundColor: Color {
        selectableUser.isSelected ? .blue : .gray
    }
}
