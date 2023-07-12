//
//  RegistrationView.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 7/2/23.
//

import SwiftUI
import PhotosUI

struct RegistrationView: View {
    @StateObject var viewModel = RegistrationViewModel()
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            
            Image("firebase-logo")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 120)
                .padding(.vertical, 32)
            
            // form fields
            VStack(spacing: 10) {
                InputView(text: $viewModel.email,
                          title: "Email Address",
                          placeholder: "name@example.com")
                .autocapitalization(.none)
                
                InputView(text: $viewModel.username,
                          title: "Username",
                          placeholder: "username")
                .autocapitalization(.none)
                
                InputView(text: $viewModel.fullname,
                          title: "fullname",
                          placeholder: "Enter your name")
                
                InputView(text: $viewModel.password,
                          title: "Password",
                          placeholder: "Enter your password",
                          isSecureField: true)
                
                ZStack(alignment: .trailing) {
                    InputView(text: $viewModel.confirmPassword,
                              title: "Confirm your password",
                              placeholder: "Confirm password",
                              isSecureField: true)
                    
                    if !viewModel.password.isEmpty && !viewModel.confirmPassword.isEmpty {
                        if viewModel.password == viewModel.confirmPassword {
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemGreen))
                        } else {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemRed))
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            // sign up button
            Button {
                Task {
                    try await viewModel.createUser()
                }
            } label: {
                HStack(spacing: 3) {
                    Text("Sign up")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
            }
            .background(Color(.systemBlue))
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0 : 0.5)
            .cornerRadius(10)
            .padding(.vertical)
            
            Spacer()
            
            // sign in button
            Button {
                dismiss()
            } label: {
                HStack(spacing: 4) {
                    Text("Already have an account?")
                    Text("Sign in")
                        .fontWeight(.bold)
                }
                .font(.system(size: 14))
            }
        }
    }
}

// MARK: - AuthenticationFormProtocol

extension RegistrationView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !viewModel.email.isEmpty
        && viewModel.email.contains("@")
        && viewModel.email.contains(".com")
        && !viewModel.password.isEmpty
        && viewModel.password.count > 5
        && viewModel.confirmPassword == viewModel.password
        && !viewModel.fullname.isEmpty
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
