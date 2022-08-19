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
    
    private func addUser(user: User) async -> Session?{
        await API.addUser(user: user)
    }
    
    func checkUser(name: String, email: String, password: String, passwordConfirmation: String) async -> Bool{
        var user: User
        
        if password != passwordConfirmation{
            return false
        }else{
            user = User(name: name, email: email, password: password)
        }
        
        let returned = await addUser(user: user)
        if returned != nil{
            await publishUserSession(session: returned!)
            // Salvando token no keychain
            let data = Data(userSession!.token.utf8)
            KeychainHelper.standard.save(data: data, service: "access-token", account: "api-matheus")
            
            return true
        }
        return false
    }
    
    func checkLogin(email: String, password: String, completion: @escaping (Bool) -> Void) {
        API.loginUser(email: email, password: password, completionHandler: {
            session in
            if session != nil{
                DispatchQueue.main.async {
                    self.userSession = session
                    
                    //salvando token no keychain
                    let data = Data(self.userSession!.token.utf8)
                    KeychainHelper.standard.save(data: data, service: "access-token", account: "api-matheus")
                    
                    completion(true)
                }
            }else{
                print("deu errado")
                completion(false)
            }
        })
    }

}
