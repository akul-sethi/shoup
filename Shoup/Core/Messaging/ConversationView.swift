//
//  ConversationView.swift
//  Shoup
//
//  Created by Akul Sethi on 5/13/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct ConversationView: View {
    @EnvironmentObject private var authViewModel: AuthViewModel
    @State private var text = ""
    var receiverId: String
    var otherUser: User? {
        authViewModel.allUsers[receiverId]
    }
    
    var body: some View {
        VStack {
            if let otherUser = otherUser {
                TitleRow(user: otherUser)
            }
            
            ScrollView {
                if let user = authViewModel.user,
                   let conversation = user.conversations[receiverId]
                {
                    ForEach(conversation, id: \.id) { message in
                        MessageBubble(message: message)
                    }
                }
                Rectangle()
                    .fill(.white)
                    .frame(height: 30)
                    
            }
            .padding(.top, 10)
            .background(.white)
            
            
            HStack {
                TextField("Enter text", text: $text)
                    .frame(height: 30)
                    .background(.white)
                    .cornerRadius(15)
                
                Button {
                    guard let user = authViewModel.user,
                    let otherUser = otherUser else {
                        return
                    }
                    
                   
                    
                    if user.conversations[receiverId] == nil {
                        user.conversations[receiverId] = [Message]()
                        otherUser.conversations[user.id] = [Message]()
                    }
                    
                    user.conversations[receiverId]!.append(Message(id: randomString(), isReceiver: false, content: text, date: Date()))
                    otherUser.conversations[user.id]!.append(Message(id: randomString(), isReceiver: true, content: text, date: Date()))
                    
                    let usersCollection = Firestore.firestore().collection("users")
                    try? usersCollection.document(user.id).setData(from: user)
                    try? usersCollection.document(otherUser.id).setData(from: otherUser)
                    
                    text = ""
                } label: {
                    Image(systemName: "paperplane.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
            }
            .padding()
        }.background(Color("Light Blue"))
    
    }
    
    func randomString() -> String {
        let allLetters = "qwertyuiopasdfghjklzxcvbnm1234567890"
        let random = allLetters.map {char in
            allLetters.randomElement() ?? "a"
        }
        return String(random)

    }
}

struct ConversationView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationView(receiverId: "").environmentObject(AuthViewModel())
    }
}
