//
//  PostViewModel.swift
//  SocialNetworking
//
//  Created by Beatriz Leonel da Silva on 10/08/22.
//

import Foundation

class PostViewModel: ObservableObject{
    @Published var postsList: [Post] = []
    
    @MainActor
    func publishPosts(posts: [Post]){
        self.postsList = posts
    }
    
    func fetchPosts() async {
        let allPosts = await fetchPostsWithImages()
        await publishPosts(posts: allPosts)
    }
    
    private func fetchPostsWithImages() async -> [Post]{
        await API.getPosts()
    }
    
    func findUserName(id: String)  async -> String {
        (await findUser(id: id)).name
    }
    
    private func findUser(id: String) async -> User{
        await API.findUser(id: id)!
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
    
}
