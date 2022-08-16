//
//  UserModel.swift
//  SocialNetworking
//
//  Created by Beatriz Leonel da Silva on 16/08/22.
//

import Foundation

struct User {
    let name : String
    let email : String
    let password : String
    
    init(name : String, email: String, password: String){
        self.name = name
        self.email = email
        self.password = password
    }
}
