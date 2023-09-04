//
//  PrivacyOptionsViewModel.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 9/4/23.
//

import Foundation
import SwiftUI

enum PrivacyOptionsViewModel: Int, CaseIterable, Identifiable {
    case appLock
    case messageDelivery
    case blockedAccounts
    
    var title: String {
        switch self {
        case .appLock: return "App lock"
        case .messageDelivery: return "Message delivery"
        case .blockedAccounts: return "Blocked accounts"
        }
    }
    
    
    var id: Int { return self.rawValue }
}
