//
//  PostCache.swift
//  Shoup
//
//  Created by Akul Sethi on 5/11/23.
//


import Foundation
import FirebaseStorage
import FirebaseFirestore
import FirebaseCore
import SwiftUI

class PostCache: ObservableObject {
    @Published var posts = [Post]()
    @Published var images = [String : Image]()

    static let storage = Storage.storage()
    static let firestore = Firestore.firestore()
    
    
    func retrievePosts() {
            PostCache.firestore.collection("posts").addSnapshotListener { (snapshot, error) in
                guard let documents = snapshot?.documents else {
                    print("No Documents")
                    return
                }
                
                self.posts = documents.compactMap { document in
                    
                    let post = try? document.data(as: Post.self)
                    
                    guard let post = post else {
                        return nil
                    }
                    
                    let imageRef = PostCache.storage.reference().child(post.imageAddress)
                    
                    imageRef.getData(maxSize: 4 * 1024 * 1024) { (data, error) in
                        guard error == nil, let uiImage = UIImage(data: data!) else {
                            print(error!.localizedDescription)
                            return
                        }
                        
                        self.images[post.imageAddress] = Image(uiImage: uiImage)
                    }
                    
                  return post
                    
                }
                
            }
    }
    
    func post(_ postObject: Post, data: Data) {
        try? PostCache.firestore.collection("posts").document(postObject.id).setData(from: postObject)
            let root = PostCache.storage.reference()
            let postRef = root.child(postObject.imageAddress)
            postRef.putData(data)
        }
    
}





