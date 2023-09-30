//
//  InputView.swift
//  Shoup
//
//  Created by Akul Sethi on 5/12/23.
//

import SwiftUI

struct InputView: View {
    @Binding var text: String
    var isSecuredField = false
    var placeholder: String
    var label: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            Text(label)
                .font(.subheadline)
                .fontWeight(.semibold)
            
            if(isSecuredField) {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
            }
            
            Divider()
            
        }
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView(text: .constant(""),
                  isSecuredField: false,
                  placeholder: "name@example.org",
                  label: "Email")
    }
}
