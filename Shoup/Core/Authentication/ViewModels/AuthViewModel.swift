//
//  AuthViewModel.swift
//  Shoup
//
//  Created by Akul Sethi on 5/12/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestoreSwift
import FirebaseFirestore

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var user: User?
    @Published var allUsers = [String : User]()
    
    var allUsersList: [User] {
        var output = [User]()
        
        for (_, user) in allUsers {
            if user.id != self.user?.id {
                output.append(user)
            }
        }
        
        return output
    }
    
    var activeListener: ListenerRegistration?
    
    init() {
        self.fetchUserData()
    }
    
    convenience init(user: User) {
        self.init()
        self.user = user
    }
    
    func createUser(email: String, password: String, username: String) async throws {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        let userId = result.user.uid
        self.userSession = result.user
        self.user = User(id: userId, name: username)
        
        try? Firestore.firestore().collection("users").document(userId).setData(from: self.user)
        
        self.fetchUserData()
        
    }
    
    func logIn(email: String, password: String) async throws {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        
        self.userSession = result.user
        self.user = User(id: result.user.uid, name: result.user.displayName ?? "")
        
        self.fetchUserData()
        
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
        self.userSession = nil
        self.user = nil
        self.allUsers = [String : User]()
        self.activeListener?.remove()
        self.activeListener = nil
    }
    
    func fetchUserData() {
        self.userSession = Auth.auth().currentUser
        
        guard let userSession = userSession else {
            return
        }
        
        self.activeListener = Firestore.firestore().collection("users").addSnapshotListener {
            snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            guard let snapshot = snapshot else {
                return
            }
            
            let allUsers = snapshot.documents.compactMap { document in
                try? document.data(as: User.self)
            }

            
            self.user = allUsers.first(where: {user in
                user.id == userSession.uid
            })
            
            
            for user in allUsers {
                self.allUsers[user.id] = user
            }
            
            if self.user == nil {
                try? self.signOut()
            }
            
        }
        
    }
   
}




