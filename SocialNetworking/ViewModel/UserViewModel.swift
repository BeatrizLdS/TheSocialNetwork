//
//  UserViewModel.swift
//  SocialNetworking
//
//  Created by Beatriz Leonel da Silva on 16/08/22.
//

import Foundation

class UserViewModel: ObservableObject{
    
    @Published var userSession: Session? = nil
    
    @MainActor
    func publishUserSession(session: Session){
        self.userSession = session
    }

    
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
    
    func checkLogin(email: String, password: String) {
        API.loginUser(email: email, password: password){
            session in
            if session != nil{
                DispatchQueue.main.async {
                    self.userSession = session
                }
                print("deu certo")
            }else{
                print("deu errado")
            }
        }

    }
    
    
}
