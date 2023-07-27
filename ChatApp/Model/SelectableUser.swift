//
//  SelectableUser.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 7/24/23.
//

import Foundation

struct SelectableUser: Identifiable, Codable, Hashable {
    let user: User
    var isSelected: Bool = false
    
    var id: String {
        return user.id
    }
}
