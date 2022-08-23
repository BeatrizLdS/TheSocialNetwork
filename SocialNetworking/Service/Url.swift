//
//  Url.swift
//  SocialNetworking
//
//  Created by Beatriz Leonel da Silva on 22/08/22.
//

import Foundation

struct Url{
    
    var host: String
    var port: Int?
    
    init(host: String, port: Int? = nil){
        self.host = host
        self.port = port
    }
    
    var urlBase : URLComponents {
        var components = URLComponents()
        components.scheme = "http"
        components.host = self.host
        if let _ = port{
            //http://localhost:8080
            components.port = self.port
        }
        return components
    }
    
    var urlGetPosts : URL {
        var urlComponents = urlBase
        urlComponents.path = "/posts"
        print(urlComponents.url!)
        return urlComponents.url!
    }
    
    var urlLoginUser : URL {
        var urlComponents = urlBase
        urlComponents.path = "/users/login"
        print(urlComponents.url!)
        return urlComponents.url!
    }
    
    var urlRegisterUser : URL{
        var urlComponents = urlBase
        urlComponents.path = "/users"
        print(urlComponents.url!)
        return urlComponents.url!
    }
    
    var urlFindUser : String {
        var urlComponents = urlBase
        urlComponents.path = "/users/"
        print(urlComponents.string!)
        return urlComponents.string!
    }
    
    var urlLogout : URL {
        var urlComponents = urlBase
        urlComponents.path = "/users/logout"
        print(urlComponents.url!)
        return urlComponents.url!
    }
    
}
