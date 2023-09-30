//
//  ProfileView.swift
//  Shoup
//
//  Created by Akul Sethi on 5/13/23.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var authViewModel: AuthViewModel
    var user: User? {
        authViewModel.user
    }
    var body: some View {
        if let user = user {
            VStack (alignment: .leading) {
                Text("hey \(user.name)")
                    .font(.title)
                Text(user.university)
                    .font(.subheadline)
                Button {
                    do {
                        try authViewModel.signOut()
                    } catch {
                        print(error.localizedDescription)
                    }
                } label: {
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.red)
                }
                Spacer()
            }
        } else {
            VStack {
                
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var auth = AuthViewModel()
    
    static var result = Task {
        do {
            try await auth.logIn(email: "akul.sethi@gmail.com", password: "qqqqqq")
        } catch {
            print(error.localizedDescription)
        }
        
    }
   
    static var previews: some View {
        
        ProfileView().environmentObject(auth)
    }
}
