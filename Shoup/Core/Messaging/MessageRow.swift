//
//  MessageRow.swift
//  Shoup
//
//  Created by Akul Sethi on 5/13/23.
//

import SwiftUI

struct MessageRow: View {
    var user: User
    var body: some View {
        HStack {
            CircleImage(image: Image("headshot"))
            Text(user.name)
            Spacer()
        }
    }
}

struct MessageRow_Previews: PreviewProvider {
    static var previews: some View {
        MessageRow(user: User(id: "hey", name: "Akul"))
    }
}
