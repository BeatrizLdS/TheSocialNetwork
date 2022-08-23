//
//  Url.swift
//  SocialNetworking
//
//  Created by Beatriz Leonel da Silva on 22/08/22.
//

import Foundation

struct Url{
    
    var urlBase : URLComponents {
        //http://localhost:8080
        var components = URLComponents()
        components.scheme = "http"
        components.host = "localhost"
        components.port = 8080
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
    
}
