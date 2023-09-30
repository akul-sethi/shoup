//
//  ContentView.swift
//  Shoup
//
//  Created by Akul Sethi on 5/11/23.
//

import SwiftUI


enum ViewMode {
    case home, post, message, profile
}

struct ContentView: View {
    @StateObject private var mode = ModeObject(activeMode: .home)
    @EnvironmentObject private var authViewModel: AuthViewModel
    

    var body: some View {
        VStack {
            if authViewModel.userSession == nil {
                LoginView()
            } else {
                switch mode.activeMode {
                case .home:
                    //Text("hey")
                    HomeView()
                case .post:
                    //Text("hey")
                    SellView()
                case .message:
                    MessageView()
                case .profile:
                    ProfileView()
                }
                Divider()
                NavBar().environmentObject(mode)
            }
        }
    }
}


class ModeObject : ObservableObject {
    @Published var activeMode: ViewMode
    
    init(activeMode: ViewMode) {
        self.activeMode = activeMode
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AuthViewModel())
    }
}


