//
//  Route.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 8/7/23.
//

import Foundation

enum Route: Hashable {
    case profile(User)
    case chatView(User)
}
