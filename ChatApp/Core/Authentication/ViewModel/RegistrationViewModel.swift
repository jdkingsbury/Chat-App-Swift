//
//  RegistrationViewModel.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 7/11/23.
//

import Foundation

class RegistrationViewModel: ObservableObject {
    @Published var username = ""
    @Published var email = ""
    @Published var fullname = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    func createUser() async throws {
        try await AuthService.shared.createUser(email: email, password: password, username: username, fullname: fullname)
        
        username = ""
        email = ""
        fullname = ""
        password = ""
    }
}
