//
//  PostViewModel.swift
//  SocialNetworking
//
//  Created by Beatriz Leonel da Silva on 10/08/22.
//

import Foundation

class PostViewModel: ObservableObject{
    
    @Published var postsList: [Post] = []
    @Published var likedPostsList: [Post] = []
    
    @MainActor
    func publishPosts(posts: [Post], likedPosts: [Post]){
        self.postsList = posts
        self.likedPostsList = likedPosts
    }
    
    func fetchPosts() async {
        let allPosts = await fetchPostsWithImages()
        let likedPosts = await fetchLikedPosts()
        await publishPosts(posts: allPosts, likedPosts: likedPosts)
    }
    
    private func fetchPostsWithImages() async -> [Post]{
        await API.getPosts()
    }
    
    private func fetchLikedPosts() async -> [Post]{
        let token = KeychainHelper.standard.read(service: "access-token", account: "api-matheus")!
        let accessToken = String(data: token, encoding: .utf8)!
        if let user = await API.getCurrentUser(token: accessToken){
            return await API.getPostsLikedByUser(userID: user.id!)
        }
        return []
    }
    
    func addPosts(postText: String) async -> Bool{
        let token = KeychainHelper.standard.read(service: "access-token", account: "api-matheus")!
        let accessToken = String(data: token, encoding: .utf8)!
        let dataPostText = Data(postText.utf8)
        if let _ = await API.addPosts(token: accessToken, postText: dataPostText) {
            await fetchPosts()
            return true
        }
        return false
    }
    
    func addLikeToPost(postID: String) async -> Post? {
        let token = KeychainHelper.standard.read(service: "access-token", account: "api-matheus")!
        let accessToken = String(data: token, encoding: .utf8)!
        print(accessToken)
        let dataPostID = Data(postID.utf8)
        if await API.addLike(postID: dataPostID, token: accessToken){
            if let post = await updatePost(postID: postID){
                return post
            }
        }
        return nil
    }
    
    func removeLikeToPost(postID: String) async -> Bool{
        let token = KeychainHelper.standard.read(service: "access-token", account: "api-matheus")!
        let accessToken = String(data: token, encoding: .utf8)!
        return await API.removeLike(postID: postID, token: accessToken)
    }
    
    func updatePost(postID: String) async -> Post?{
        if let updatedPost = await API.getPostByID(postID: postID){
            print(updatedPost)
            return updatedPost
        }
        return nil
    }
    
    func logOut() async -> Bool{
        let token = KeychainHelper.standard.read(service: "access-token", account: "api-matheus")!
        let accessToken = String(data: token, encoding: .utf8)!
        if let _ = await API.logOut(token: accessToken) {
            KeychainHelper.standard.delete(service: "access-token", account: "api-matheus")
            return true
        }
        return false
    }
    
    func findUserName(id: String)  async -> String {
        (await findUserByID(id: id)).name
    }
    
    private func findUserByID(id: String) async -> User{
        await API.findUserByID(id: id)!
    }
    
}
