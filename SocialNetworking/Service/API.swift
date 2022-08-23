//
//  API.swift
//  SocialNetworking
//
//  Created by Beatriz Leonel da Silva on 10/08/22.
//

import Foundation

class API {
    
    static let localhost : String = "localhost"
    static let port : Int = 8080
    static let remotehost : String = "macdabia.local"
    
    enum APIError: Error{
        case serviceError
    }
    
    static func getPosts() async -> [Post] {
        
        //Criar requisicao
        let urlRequest = URLRequest(url: Url(host: localhost, port: port).urlGetPosts)

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
    
    static func addUser(user: User) async -> Session? {
        let urlComponents = Url(host: localhost, port: port).urlRegisterUser
        
        //Configuração da request
        var urlRequest = URLRequest(url: urlComponents)
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
            
            print("Add Users Response: ")
            print(response)
            
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
    
    static func findUser(id: String) async -> User? {
        let url = URL(string: Url(host: localhost, port: port).urlFindUser + "\(id)")
        
        //setar requisição
        let urlRequest = URLRequest(url: url!)
        
        do{
            //realização de requisição
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            print("Find User by ID Response: ")
            print(response)
            
            if let responseHeader = response as? HTTPURLResponse {
                if ((responseHeader.statusCode >= 200) && (responseHeader.statusCode < 300)){
                    let user = try JSONDecoder().decode(User.self, from: data)
                    return user
                }
            }
        }catch{
            print("Deu ruim no meio do caminho")
            print(error)
        }
        
        return nil
    }
    
    static func loginUser(email: String, password: String, completionHandler: @escaping ( Session?) -> Void) {
        
        var url = Url(host: localhost, port: port).urlLoginUser
        
        //configuração de request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let authData = (email + ":" + password).data(using: .utf8)!.base64EncodedString()
        request.addValue("Basic \(authData)", forHTTPHeaderField: "Authorization")
        
        
        //realização de request localhost
        executeRequest(request: request, completionHandler: completionHandler)
    }
    
    static func executeRequest(request : URLRequest, completionHandler: @escaping (Session?) -> Void) -> Void{
        let urlSession = URLSession.shared
        
        let dataTask = urlSession.dataTask(with: request, completionHandler: { data, response, error in
            guard let responseStatus = response as? HTTPURLResponse, responseStatus.statusCode == 200 else {
                completionHandler(nil)
                return
            }
            
            guard let data = data, error == nil else{
                completionHandler(nil)
                return
            }
            
            do{
                let session = try JSONDecoder().decode(Session.self, from: data)
                completionHandler(session)
            }catch{
                completionHandler(nil)
            }
        })
        dataTask.resume()
    }
    
    static func logOut(token: String) async -> Session? {
        
        let url = Url(host: localhost, port: port).urlLogout

        print("Token de acesso: ", token)
        
        //configuração de request
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        do{
            //realização de requisição
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            print("User Logout Response: ")
            print(response)
            
            if let responseHeader = response as? HTTPURLResponse {
                if ((responseHeader.statusCode >= 200) && (responseHeader.statusCode < 300)){
                    let session = try JSONDecoder().decode(Session.self, from: data)
                    return session
                }
            }
        }catch{
            print("Deu ruim no meio do caminho")
            print(error)
        }
        return nil
    }
    
}
