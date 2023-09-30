//
//  ShoupApp.swift
//  Shoup
//
//  Created by Akul Sethi on 5/11/23.
//

import SwiftUI
import FirebaseCore

@main
struct ShoupApp: App {
    @StateObject private var authViewModel = AuthViewModel()
    @StateObject private var postCache = PostCache()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(authViewModel)
                .environmentObject(postCache)
        }
    }
}


