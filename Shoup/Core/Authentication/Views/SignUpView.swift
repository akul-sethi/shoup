//
//  SignUpView.swift
//  Shoup
//
//  Created by Akul Sethi on 5/12/23.
//

import SwiftUI

struct SignUpView: View {
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmation = ""
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var authViewModel: AuthViewModel
   
    var body: some View {
        VStack {
            Image("Shoup Inverse")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            
            VStack(spacing: 16) {
                InputView(text: $username, placeholder: "John Doe", label: "Username")
                InputView(text: $email, placeholder: "John@example.org", label: "Email")

                InputView(text: $password,
                         isSecuredField: true, placeholder: "12345", label: "Password")

                InputView(text: $confirmation,
                          isSecuredField: true, placeholder: "12345", label: "Confirmation")

            }
            .padding(.horizontal)
            .padding(.top, 30)
            
            Button {
                Task {
                    try? await authViewModel.createUser(email: email, password: password, username: username)
                }
            } label: {
                HStack {
                    Text("Sign up")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right")
                }
                .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                .foregroundColor(.white)
            }
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1 : 0.5)
            .background(Color("Dark Blue"))
            .cornerRadius(20)
            .padding(.top, 24)
            
            
            
            Spacer()
            
            Button {
                self.dismiss()
            } label: {
                HStack {
                    Text("Already have an account?")
                    Text("Log in")
                        .fontWeight(.bold)
                }
            }
        
        }
        
    }
}

extension SignUpView: AuthenticationFormValid {
    var formIsValid: Bool {
        !username.isEmpty &&
        !email.isEmpty &&
        !password.isEmpty &&
        !confirmation.isEmpty &&
        password.count > 5 &&
        password == confirmation &&
        email.contains("@")
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
