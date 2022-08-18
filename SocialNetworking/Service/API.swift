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
    
    static func addUser(user: User) async -> Session? {
        let url = URL(string: "http://adaspace.local/users")
        
        //Configuração da request
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        urlRequest.allHTTPHeaderFields = [
            "accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        do{
            let payload = try JSONEncoder().encode(user)
            urlRequest.httpBody = payload
            
            //Realização de request
            let(data, response) = try await URLSession.shared.data(for: urlRequest)
            
            print(response)
            print(data)
            
            //Verificação da request
            if let responseHeader = response as? HTTPURLResponse {
                if ((responseHeader.statusCode >= 200) && (responseHeader.statusCode < 300)){
                    let session = try JSONDecoder().decode(Session.self, from: data)
                    return session
                }
            }
            
        } catch {
            print(error)
        }
        print("Caiu no ultimo false")
        return nil
    }
    
    
    static func loginUser(email: String, password: String, completionHandler: @escaping (Session?) -> Void) {
        
        let url = URL(string: "http://adaspace.local/users/login")
        
        //configuração de request
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"

        let authData = (email + ":" + password).data(using: .utf8)!.base64EncodedString()
        request.addValue("Basic \(authData)", forHTTPHeaderField: "Authorization")
        
        //realização de request
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            if error != nil{
                return
            }
            
            if let data = data {
                do {
                    let session = try JSONDecoder().decode(Session.self, from: data)
                    completionHandler(session)
                }
                catch{
                    print("Could not decode the data. Error: \(error)")
                }
            }
        }
        task.resume()
    }
    
}
