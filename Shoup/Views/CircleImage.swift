//
//  CircleImage.swift
//  Shoup
//
//  Created by Akul Sethi on 5/11/23.
//

import SwiftUI

struct CircleImage: View {
    var image: Image
    var body: some View {
        image
            .resizable()
            .scaledToFit()
            .frame(width: 90, height: 60)
            .clipShape(Circle())
            .overlay {
                Circle().stroke(.white, lineWidth: 3)
            }
            .shadow(radius: 7)
            
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: Image("headshot"))
    }
}
