//
//  PostModel.swift
//  SocialNetworking
//
//  Created by Beatriz Leonel da Silva on 10/08/22.
//

import Foundation

struct Post : Decodable{
    
    let id : String
    let content : String
    let user_id : String
    let created_at : String
    let updated_at : String
    
}
