//
//  Route.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 8/7/23.
//

import Foundation
import SwiftUI

class Router: ObservableObject {
    
    public enum Destination: Codable, Hashable {
        case darkMode(User)
        case activeStatus(User)
    //    case accessibility(User)
    //    case privacyAndSafety(User)
    //    case notifications(User)
    //    case profile(User)
    //    case chatView(User)
    }
    
    @Published var navPath = NavigationPath()
    
    func navigate(to destination: Destination) {
        navPath.append(destination)
    }
    
    func navigateBack() {
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
    
}
