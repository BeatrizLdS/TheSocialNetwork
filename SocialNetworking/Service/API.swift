//
//  API.swift
//  SocialNetworking
//
//  Created by Beatriz Leonel da Silva on 10/08/22.
//

import Foundation

class API {
    
    static func getPosts() async -> [Post] {
        
        //Criar requisicao
        let url : URL = URL(string: "http://adaspace.local/posts")!
        let urlRequest = URLRequest(url: url)

        //Executar requisicao
        do{
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            if let httpsResponse = response as? HTTPURLResponse{
                print("status: ", httpsResponse.statusCode)
                
                //Verificar a resposta
                switch httpsResponse.statusCode{
                    case 200...300:
                    
                        //Decode data => Post
                        let postsList : [Post] = try JSONDecoder().decode([Post].self, from: data)
                        return postsList
                    default:
                        print("Deu ruim quando foi receber os dados do post")
                    
                }
                
            }
        }catch{
            print(error)
        }
        
        return []
    }
    
}
