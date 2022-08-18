//
//  PostCell.swift
//  SocialNetworking
//
//  Created by Beatriz Leonel da Silva on 11/08/22.
//

import Foundation
import SwiftUI

struct PostCell: View{
    let post : Post
    
    init(post: Post){
        self.post = post
    }
    
    var body: some View{
        VStack(alignment: .leading, spacing: 5) {
            Text(post.userId).bold()
            Text(post.content)
            if post.media != nil{
                AsyncImage(url: URL(string: "http://adaspace.local/" + post.media!) ) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
//                        .frame(width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.width - 100)
//                        .clipped()
                } placeholder: {
                    Color.yellow.opacity(0.25)
                }
                .frame(width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.width - 100)
                
                Spacer()
            }
            Text(String(post.likeCount))
            Text(post.createdAt)
            Text(post.updatedAt)
        }.background(Color.gray)
    }
    
    
}

