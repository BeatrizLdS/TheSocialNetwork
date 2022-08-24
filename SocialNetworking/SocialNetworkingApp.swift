//
//  SocialNetworkingApp.swift
//  SocialNetworking
//
//  Created by Beatriz Leonel da Silva on 10/08/22.
//

import SwiftUI

@main
struct SocialNetworkingApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
        
//            let accessToken = String(data: token, encoding: .utf8)!
//            
//            if let token = KeychainHelper.standard.read(service: "access-token", account: "api-matheus")!
            InitialView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
