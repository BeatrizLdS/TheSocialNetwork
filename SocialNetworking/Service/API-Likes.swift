//
//  API-Likes.swift
//  SocialNetworking
//
//  Created by Beatriz Leonel da Silva on 25/08/22.
//

import Foundation

extension API {
    static func getPostsLikedByUser(userID: String) async -> [Post] {
        
        let url = URL(string: Url(host: localhost, port: port).urlLikedByUser.absoluteString + "\(userID)")
        
        //Criar requisicao
        let urlRequest = URLRequest(url: url!)

        //Executar requisicao
        do{
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            print("GetPost Response: ")
            print(response)
        
            //Verificar a resposta
            if let responseHeader = response as? HTTPURLResponse {
                if ((responseHeader.statusCode >= 200) && (responseHeader.statusCode < 300)){
                    let likedPostsList : [Post] = try JSONDecoder().decode([Post].self, from: data)
                    return likedPostsList
                }
            }
        }catch{
            print("Deu ruim no meio do caminho")
            print(error)
        }
        
        return []
    }
    
    static func removeLike(postID: String, token: String) async -> Bool{
        let url = URL(string: Url(host: localhost, port: port).urlLike.absoluteString + "/\(postID)")
        
        //configuração de request
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "DELETE"
        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        do{
            //realização de requisição
            let (_, response) = try await URLSession.shared.data(for: urlRequest)
            
            print("Remove like to post Response: ")
            print(response)
            
            if let responseHeader = response as? HTTPURLResponse {
                if ((responseHeader.statusCode >= 200) && (responseHeader.statusCode < 300)){
                    return true
                }
            }
        }catch{
            print("Deu ruim no meio do caminho")
            print(error)
        }
        return false
    }
    
    static func addLike(postID : Data, token: String) async -> Bool {
        let url = Url(host: localhost, port: port).urlLike
        
        //configuração de request
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("*/*", forHTTPHeaderField: "accept")
        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("text/plain", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = postID
        
        do{
            //realização de requisição
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            print("Add like to post Response: ")
            print(response)
            
            
            
            if let responseHeader = response as? HTTPURLResponse {
                if ((responseHeader.statusCode >= 200) && (responseHeader.statusCode < 300)){
                    return true
                }
            }
        }catch{
            print("Deu ruim no meio do caminho")
            print(error)
        }
        return false
    }
}
