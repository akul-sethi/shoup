//
//  HomeView.swift
//  Shoup
//
//  Created by Akul Sethi on 5/11/23.
//
import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var postCache: PostCache
    
    var body: some View {
        VStack{
            PostListView()
            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(PostCache())
    }
}
