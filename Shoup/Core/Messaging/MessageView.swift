//
//  MessageView.swift
//  Shoup
//
//  Created by Akul Sethi on 5/11/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct MessageView: View {
    @EnvironmentObject private var authViewModel: AuthViewModel

    
    var body: some View {
        NavigationStack {
            List(authViewModel.allUsersList) { user in
                NavigationLink {
                    ConversationView(receiverId: user.id)
                } label: {
                    MessageRow(user: user)
                }
              
             }
            }
        }
    }
    


struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView().environmentObject(AuthViewModel())
    }
}

