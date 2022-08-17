//
//  UserViewModel.swift
//  SocialNetworking
//
//  Created by Beatriz Leonel da Silva on 16/08/22.
//

import Foundation

class UserViewModel: ObservableObject{
    @Published var user: User? = nil
    
    private func addUser(user: User) async -> Bool{
        await API.addUser(user: user)
    }
    
    func checkUser(name: String, email: String, password: String, passwordConfirmation: String) async -> Bool{
        var user: User
        
        if password != passwordConfirmation{
            return false
        }else{
            user = User(name: name, email: email, password: password)
        }
        return await addUser(user: user)
    }
    
}
