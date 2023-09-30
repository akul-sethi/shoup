//
//  Message.swift
//  Shoup
//
//  Created by Akul Sethi on 5/11/23.
//

import Foundation
import FirebaseFirestoreSwift


struct Message: Identifiable, Codable{
    var id: String
    var isReceiver: Bool
    var content: String
    var date: Date
}
