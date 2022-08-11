//
//  PostModel.swift
//  SocialNetworking
//
//  Created by Beatriz Leonel da Silva on 10/08/22.
//

import Foundation

struct Post : Decodable{
    let id : String
    let media : String?
    let content : String
    let likeCount : Int
    let userId : String
    let createdAt : String
    let updatedAt : String
    
    enum CodingKeys: String, CodingKey {
        case id, media, content
        case userId = "user_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case likeCount = "like_count"
    }
}
