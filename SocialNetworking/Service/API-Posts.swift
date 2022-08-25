//
//  API-Posts.swift
//  SocialNetworking
//
//  Created by Beatriz Leonel da Silva on 25/08/22.
//

import Foundation

extension API {
    
    static func getPosts() async -> [Post] {
        
        //Criar requisicao
        let urlRequest = URLRequest(url: Url(host: localhost, port: port).urlPosts)

        //Executar requisicao
        do{
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            print("GetPost Response: ")
            print(response)
            
            if let httpsResponse = response as? HTTPURLResponse{
                print("status: ", httpsResponse.statusCode)
                
                //Verificar a resposta
                switch httpsResponse.statusCode{
                    case 200...300:
                        
                        //Decode data => Post
                        print(data)
                        let postsList : [Post] = try JSONDecoder().decode([Post].self, from: data)
                        print("Deu bom transformar os dados!")
                        return postsList
                        
                    default:
                        print("Deu ruim quando foi receber os dados do post")
                }
            }
        }catch{
            print("Deu ruim no meio do caminho")
            print(error)
        }
        
        return []
    }
    
    static func addPosts(token: String, postText: Data) async -> Post?{
        let url = Url(host: localhost, port: port).urlPosts

        print("Token de acesso: ", token)
        
        //configuração de request
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("text/plain", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = postText
        
        do{
            //realização de requisição
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            print("Add Post Response: ")
            print(response)
            
            if let responseHeader = response as? HTTPURLResponse {
                if ((responseHeader.statusCode >= 200) && (responseHeader.statusCode < 300)){
                    let post = try JSONDecoder().decode(Post.self, from: data)
                    return post
                }
            }
        }catch{
            print("Deu ruim no meio do caminho")
            print(error)
        }
        return nil
    }
    
    static func getPostByID(postID: String) async -> Post? {
        let url = URL(string: Url(host: localhost, port: port).urlPosts.absoluteString + "/\(postID)")
        
        //configuração de request
        let urlRequest = URLRequest(url: url!)
        
        do{
            //realização de requisição
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            print("get post Response: ")
            print(response)
            
            if let responseHeader = response as? HTTPURLResponse {
                if ((responseHeader.statusCode >= 200) && (responseHeader.statusCode < 300)){
                    let post = try JSONDecoder().decode(Post.self, from: data)
                    return post
                }
            }
        }catch{
            print("Deu ruim no meio do caminho")
            print(error)
        }
        return nil
    }
}
