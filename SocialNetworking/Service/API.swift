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
        var urlRequest = URLRequest(url: url)
        
        //configurar requisicao
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = [
            "content-type" : "application/json"
        ]
        
        //Executar requisicao
        do{
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            if let httpsResponse = response as? HTTPURLResponse{
                print("status: ", httpsResponse.statusCode)
                
                //Verificar a resposta
                switch httpsResponse.statusCode{
                case 200...300:
                    print("Deu bom")
                    
                    //Decode data => Post
                    print(data)
                    
                default:
                    print("Deu ruim trazer os dados")
                }
            }
        }catch{
            print("Deu ruim no meio do caminho")
            print(error)
        }
        
        return []
    }
    
}
