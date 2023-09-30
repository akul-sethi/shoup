//
//  Conversation.swift
//  Shoup
//
//  Created by Akul Sethi on 5/13/23.
//

import Foundation
import FirebaseFirestoreSwift


struct Conversation: Codable {
    var recieverId: String
    var recieverName: String
    var messages: [Message]
    
}

enum ConversationErrors: Error {
    case alreadyExists
    case noUser
    case noConversation
}
