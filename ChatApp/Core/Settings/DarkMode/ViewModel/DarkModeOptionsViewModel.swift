//
//  DarkModeViewModel.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 8/16/23.
//

import Foundation

enum DarkModeOptionsViewModel: Int, CaseIterable, Identifiable {
    case on
    case off
    case system
    
    var title: String {
        switch self {
        case .on: return "On"
        case .off: return "Off"
        case .system: return "System"
        }
    }
    
    var id: Int { return self.rawValue }
}
