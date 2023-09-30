//
//  MessageModel.swift
//  Shoup
//
//  Created by Akul Sethi on 5/12/23.
//

import SwiftUI

struct MessageBubble: View {
    @State private var showDate = false
    var message: Message
    var body: some View {
        VStack(alignment: message.isReceiver ? .leading : .trailing) {
            HStack {
                Text(message.content)
                    .padding()
                    .background(message.isReceiver ? Color("Light Gray") : Color("Light Blue"))
                    .cornerRadius(20)
            }.frame(width: 300,
                    alignment: message.isReceiver ? .leading : .trailing)
            
            if showDate {
                Text("\(message.date.formatted(.dateTime.hour().minute()))")
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .padding(message.isReceiver ?  .leading : .trailing, 20)
                
            }
            
        }.frame(maxWidth: .infinity, alignment: message.isReceiver ? .leading : .trailing)
            .padding(message.isReceiver ? .leading : .trailing)
            .padding(.horizontal)
            .onTapGesture {
                showDate.toggle()
            }
    }
}

struct MessageBubble_Previews: PreviewProvider {
    static var previews: some View {
        MessageBubble(message:
                        Message(id: "adf",
                                isReceiver: false,
            content: "Hey whats up",
                                date: Date()))
    }
}
