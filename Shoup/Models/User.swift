//
//  User.swift
//  Shoup
//
//  Created by Akul Sethi on 5/12/23.
//

import Foundation
import FirebaseFirestoreSwift


class User: Identifiable, Codable {
    var id: String
    var name: String
    var university: String
    var conversations: [String : [Message]]
    var posts: [Post]
    var profileImageAddress: String?
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
        self.university = "Northeastern"
        self.conversations = [String : [Message]]()
        self.posts = [Post]()
    }
}
