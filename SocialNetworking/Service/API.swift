//
//  API.swift
//  SocialNetworking
//
//  Created by Beatriz Leonel da Silva on 10/08/22.
//

import Foundation

class API {
    
    
    static func execute(_ urlRequest: URLRequest) async throws -> Data  {
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        if let httpsResponse = response as? HTTPURLResponse{
            print("status: ", httpsResponse.statusCode)
        }
        return data
    }
    
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
                        print("Os dados dos posts foram recebidos com sucesso")
                        
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
    
    static func addUser(user: User) async -> Bool{
        let url = URL(string: "http://adaspace.local/users")
        
        //Configuração da request
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        
        do{
            let serializationData = try JSONSerialization.data(withJSONObject: user, options: .fragmentsAllowed)
            urlRequest.httpBody = serializationData
            
            //Realização de request
            let(data, response) = try await URLSession.shared.data(for: urlRequest)
            
            //Verificação da request
            if let responseHeader = response as? HTTPURLResponse {
                return (responseHeader.statusCode == 200)
            }
            
        } catch {
            print(error)
        }
        return false
    }
    
}
