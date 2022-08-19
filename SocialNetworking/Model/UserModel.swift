//
//  UserModel.swift
//  SocialNetworking
//
//  Created by Beatriz Leonel da Silva on 16/08/22.
//

import Foundation

struct User : Codable { //Encodable + Decodable
    
    let name : String
    let email : String
    let password : String?
    let avatar : String?
    
    init(name : String, email: String, password: String? = nil, avatar: String? = nil){
        self.name = name
        self.email = email
        self.password = password
        self.avatar = avatar
    }
    
    enum CodingKeys : String, CodingKey {
        case name, email, password, avatar
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.password, forKey: .password)
        try container.encode(self.email, forKey: .email)
        try container.encode(self.name, forKey: .name)
    }
    
}
