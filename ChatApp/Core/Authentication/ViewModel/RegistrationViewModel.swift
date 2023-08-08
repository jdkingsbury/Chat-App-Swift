//
//  RegistrationViewModel.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 7/11/23.
//

import Foundation
import FirebaseAuth

class RegistrationViewModel: ObservableObject {
    @Published var username = ""
    @Published var email = ""
    @Published var fullname = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var showAlert = false
    @Published var authError: AuthError?
    
    func createUser() async throws {
        
        do {
            try await AuthService.shared.createUser(email: email, password: password, username: username, fullname: fullname)
            username = ""
            email = ""
            fullname = ""
            password = ""
        } catch {
            let authError = AuthErrorCode.Code(rawValue: (error as NSError).code)
            self.showAlert = true
            self.authError = AuthError(authErrorCode: authError ?? .userNotFound)
        }
    }
}
