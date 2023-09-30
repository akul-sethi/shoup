//
//  LoginView.swift
//  Shoup
//
//  Created by Akul Sethi on 5/12/23.
//

import SwiftUI

protocol AuthenticationFormValid {
    var formIsValid: Bool {get}
}

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject private var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("Shoup Inverse")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height:  200)
                VStack(spacing: 16) {
                    InputView(text: $email, placeholder: "name@example.org", label: "Email")
                    InputView(text: $password, isSecuredField: true, placeholder: "12345", label: "Password")
                }
                .padding(.horizontal)
                .padding(.top, 30)
                
                Button {
                    Task {
                       try await authViewModel.logIn(email: email, password: password)
                    }
                } label: {
                    HStack {
                        Text("Log In")
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
                
                NavigationLink {
                    SignUpView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack {
                        Text("Don't have an account?")
                        Text("Sign up")
                            .fontWeight(.bold)
                    }
                }
            }
        }
    }
}

extension LoginView: AuthenticationFormValid {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
