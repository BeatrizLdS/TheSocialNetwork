//
//  ContentView.swift
//  SocialNetworking
//
//  Created by Beatriz Leonel da Silva on 10/08/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @ObservedObject var viewModel:
    PostViewModel = PostViewModel()

    var body: some View {
        NavigationView {
            
        }
        .task{
            await viewModel.fetchPosts()
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
