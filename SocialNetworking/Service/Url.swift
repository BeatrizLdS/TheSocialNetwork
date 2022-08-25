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
    
    var urlPosts : URL {
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
    
    var urlFindUser : URL {
        var urlComponents = urlBase
        urlComponents.path = "/users/"
        print(urlComponents.url!)
        return urlComponents.url!
    }
    
    var urlLogout : URL {
        var urlComponents = urlBase
        urlComponents.path = "/users/logout"
        print(urlComponents.url!)
        return urlComponents.url!
    }
    
    var urlLike : URL {
        var urlComponents = urlBase
        urlComponents.path = "/likes"
        print(urlComponents.url!)
        return urlComponents.url!
    }
    
    var urlLikedByUser : URL {
        var urlComponents = urlBase
        urlComponents.path = "/likes/liked_posts/"
        print(urlComponents.url!)
        return urlComponents.url!
    }

}
