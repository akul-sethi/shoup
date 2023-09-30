//
//  NavBar.swift
//  Shoup
//
//  Created by Akul Sethi on 5/11/23.
//
import SwiftUI

struct NavBar: View {
    @EnvironmentObject private var mode: ModeObject
    var body: some View {
         HStack {
            Group {
                Button {
                    mode.activeMode = .home
                } label: {
                    Image(systemName: "house").foregroundColor(.black)
                }
                Button {
                    mode.activeMode = .message
                } label: {
                    Image(systemName: "message").foregroundColor(.black)
                }
                Button {
                    mode.activeMode = .post
                } label: {
                    Image(systemName: "plus.circle").foregroundColor(.black)
                }

                Button {
                    mode.activeMode = .profile
                } label: {
                    Image(systemName: "person").foregroundColor(.black)
                }

            }
            .padding(.horizontal)
        }
        .frame(height: 25.0)
 }
}

struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        NavBar().environmentObject(ModeObject(activeMode: .home))
    }
}
