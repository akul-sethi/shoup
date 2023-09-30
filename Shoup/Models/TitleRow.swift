//
//  TitleRow.swift
//  Shoup
//
//  Created by Akul Sethi on 5/12/23.
//

import SwiftUI

struct TitleRow: View {
    var user: User
    var body: some View {
        HStack {
            CircleImage(image: Image("headshot"))
            HStack {
                VStack(alignment: .leading) {
                    Text(user.name)
                        .font(.title)
                        .bold()
                    Text("Online")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            
            Image(systemName: "phone.circle.fill")
                .resizable()
                .foregroundColor(.gray)
                .frame(width: 30, height: 30)
            
        }.padding()
         .background(Color("Light Blue"))
    }
}

struct TitleRow_Previews: PreviewProvider {
    static var previews: some View {
        TitleRow(user: User(id: "wer", name: "Akul"))
    }
}
