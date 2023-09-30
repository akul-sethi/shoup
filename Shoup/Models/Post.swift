//
//  Post.swift
//  Shoup
//
//  Created by Akul Sethi on 5/11/23.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift


struct Post: Identifiable, Codable {
    var id: String
    var seller: String
    var university: String
    var description: String
    var price: Int
    var name: String
    var imageAddress: String
}


