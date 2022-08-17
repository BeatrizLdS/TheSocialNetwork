//
//  SessionModel.swift
//  SocialNetworking
//
//  Created by Beatriz Leonel da Silva on 16/08/22.
//

import Foundation

struct Session: Decodable {
    let token: String
    let user: User
    
    init (token: String, user: User){
        self.token = token
        self.user = user
    }
    
    enum CodingKeys: String, CodingKey {
        case token, user
    }
    
}
