//
//  Color.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 8/7/23.
//

import SwiftUI

extension Color {
    static var theme = Theme()
}

struct Theme {
    let primaryText = Color("PrimaryTextColor")
    let background = Color("BackgroundColor")
    let secondaryBackground = Color("SecondaryBackground")
}

