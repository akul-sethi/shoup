//
//  PostListView.swift
//  Shoup
//
//  Created by Akul Sethi on 5/11/23.
//
import SwiftUI

struct PostListView: View {
    @EnvironmentObject private var postCache: PostCache
    var body: some View {
        NavigationStack {
            List(postCache.posts) { post in
                NavigationLink {
                    DetailView(post: post)
                } label: {
                    if let image = postCache.images[post.imageAddress] {
                        image.resizable()
                            .scaledToFit()
                    }
                }
            }
            .onAppear {
                postCache.retrievePosts()
            }
        }
    }
}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        PostListView()
            .environmentObject(PostCache())
    }
}
