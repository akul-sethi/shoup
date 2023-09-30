////
////  PostCache.swift
////  Shoup
////
////  Created by Akul Sethi on 5/11/23.
////
//
//
//import Foundation
//import FirebaseStorage
//import FirebaseFirestore
//import FirebaseCore
//import SwiftUI
//
//class DataCache: ObservableObject {
//    @Published var posts = [Post]()
//    @Published var images = [String : Image]()
//    let isLocal: Bool
////    var postsWatcher: DispatchSourceFileSystemObject
////    var imagesWatcher: DispatchSourceFileSystemObject
////    let postsURL: URL
////    let imagesFolder: URL
////    let imagesFolderDescriptor: Int32
////    let postsHandle: FileHandle
//    static let storage = Storage.storage()
//    static let firestore = Firestore.firestore()
//
//    init(isLocal: Bool) {
//        self.isLocal = isLocal
////        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
////        let baseURL = urls[0]
////        self.postsURL = baseURL.appendingPathComponent("shoupPosts.json")
////        self.imagesFolder = baseURL.appendingPathComponent("images/")
////
////
////        do {
////            if !FileManager.default.fileExists(atPath: postsURL.absoluteString) {
////                print("dontHave")
////                let emptyPostsTemplate = "[]"
////                try emptyPostsTemplate.write(to: postsURL, atomically: true, encoding: .utf8)
////            } else {
////                print("have file")
////            }
////
////            if !FileManager.default.fileExists(atPath: imagesFolder.absoluteString) {
////                print("Dont have folder")
////                try FileManager.default.createDirectory(at: imagesFolder, withIntermediateDirectories: true)
////            } else {
////                print("have folder")
////            }
////        } catch {
////            print(error.localizedDescription)
////        }
////
////
////        self.postsHandle = try! FileHandle(forReadingFrom: self.postsURL)
////        let postsDescriptor = self.postsHandle.fileDescriptor
////        self.imagesFolderDescriptor = open(imagesFolder.path(), O_EVTONLY)
////
////        self.postsWatcher = DispatchSource.makeFileSystemObjectSource(fileDescriptor: postsDescriptor,
////                                                                 eventMask: .extend,
////                                                                 queue: DispatchQueue.main)
////        self.imagesWatcher = DispatchSource.makeFileSystemObjectSource(fileDescriptor: self.imagesFolderDescriptor,
////                                                                      eventMask: .extend,
////                                                                      queue: DispatchQueue.main)
////
////
////        postsWatcher.setEventHandler {
////            let decoder = JSONDecoder()
////            self.posts = try! decoder.decode([Post].self,
////                                             from: Data(contentsOf: self.postsURL))
////        }
////
////        imagesWatcher.setEventHandler {
////            do {
////                for string in try FileManager.default.contentsOfDirectory(atPath: self.imagesFolder.relativeString) {
////                    let imageURL = self.imagesFolder.appendingPathComponent(string)
////                    let data = try Data(contentsOf: imageURL)
////                    let uiImage = UIImage(data: data)
////                    if let uiImage = uiImage {
////                        self.images[string] = Image(uiImage: uiImage)
////                    }
////                }
////            } catch {
////                print(error.localizedDescription)
////            }
////
////        }
//
////        postsWatcher.setCancelHandler {
////            try? self.postsHandle.close()
////        }
////
////        imagesWatcher.setCancelHandler {
////            close(self.imagesFolderDescriptor)
////        }
////
//    }
////
////    deinit {
////        postsWatcher.cancel()
////        imagesWatcher.cancel()
////    }
//
//    func retrievePosts() {
////        if isLocal {
////            self.postsWatcher.resume()
////            self.imagesWatcher.resume()
////        } else {
//            DataCache.firestore.collection("posts").addSnapshotListener { (snapshot, error) in
//                guard let documents = snapshot?.documents else {
//                    print("No Documents")
//                    return
//                }
//
//                self.posts = documents.compactMap { document in
//
//                    let post = try? document.data(as: Post.self)
//
//                    guard let post = post else {
//                        return nil
//                    }
//
//                    let imageRef = DataCache.storage.reference().child(post.imageAddress)
//
//                    imageRef.getData(maxSize: 4 * 1024 * 1024) { (data, error) in
//                        guard error == nil, let uiImage = UIImage(data: data!) else {
//                            print(error!.localizedDescription)
//                            return
//                        }
//
//                        self.images[post.imageAddress] = Image(uiImage: uiImage)
//                    }
//
//                  return post
//
//                }
//
//            }
////        }
//    }
//
//    func post(_ postObject: Post, data: Data) {
////        if isLocal {
////            do {
////                let postsString = try String(contentsOf: self.postsURL)
////                let post = try String(data: JSONEncoder().encode(postObject), encoding: .utf8)
////                if let post = post {
////                    let newString = postsString.dropLast(1) + "," + post + "]"
////                    try newString.write(to: self.postsURL,
////                                        atomically: true,
////                                        encoding: .utf8)
////                }
////                let imageUrl = self.imagesFolder.appendingPathComponent(postObject.imageAddress)
////                try data.write(to: imageUrl)
////
////            } catch {
////                print(error.localizedDescription)
////            }
////
////        } else {
//        try? DataCache.firestore.collection("posts").document(postObject.id!).setData(from: postObject)
//            let root = DataCache.storage.reference()
//            let postRef = root.child(postObject.imageAddress)
//            postRef.putData(data)
//        }
////    }
//
//
//}
//
//
//
//
//
