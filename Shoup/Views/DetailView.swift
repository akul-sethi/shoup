//
//  DetailView.swift
//  Shoup
//
//  Created by Akul Sethi on 5/11/23.
//
import SwiftUI

struct DetailView: View {
    @EnvironmentObject private var postCache: PostCache
    var post: Post
    var body: some View {
            VStack {
                ScrollView {
                    Divider()
                    HStack{
                        CircleImage(image: Image("headshot"))
                        VStack(alignment: .leading){
                            Text(post.seller).font(.headline)
                            Text("Northeastern, East village").font(.subheadline)
                        }
                        Spacer()
                    }
                    VStack (alignment: .leading){
                        if let image = postCache.images[post.imageAddress]{
                            image
                                .resizable()
                                .scaledToFill()
                        }
                        Group {
                            HStack {
                                Text(post.seller).font(.headline)
                                Text(post.description)
                            }
                            
                            
                            Text("Description here")
                            
                            HStack {
                                Text("Price").font(.headline)
                                Text("\(post.price)")
                            }
                        }
                        .padding()
                    }
                }
            
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(post: Post(id: "asdfads", seller: "Stav", university: "Northeastern", description: "Cool crewneck", price: 10, name: "Thingy", imageAddress: "")).environmentObject(PostCache())
    }
}
