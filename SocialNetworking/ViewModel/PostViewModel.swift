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
    }
    
    private func fetchPostsWithImages() async -> [Post]{
        await API.getPosts()
    }
}
