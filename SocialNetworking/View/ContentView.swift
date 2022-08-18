//
//  ContentView.swift
//  SocialNetworking
//
//  Created by Beatriz Leonel da Silva on 10/08/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @ObservedObject var viewModel: PostViewModel = PostViewModel()

    var body: some View {
        NavigationView{
            ZStack{
                if viewModel.postsList.isEmpty {
                    emptyStateView
                } else {
                    postsListView
                }
            }
            .task{
                await viewModel.fetchPosts()
            }
            .navigationBarTitle("Feed", displayMode: .inline)
            .toolbar{
                ToolbarItem(placement: .primaryAction){
                    Button{
                        print("Fazer logout")
                    }label: {
                        Text("LogOut")
                    }
                }
            }
        }
    }
    var emptyStateView: some View {
        VStack {
            Text("Loading").font(.title)
            ProgressView()
                .progressViewStyle(.circular)
                .scaleEffect(1.5)
                .padding()
        }
    }
    
    var postsListView: some View{
        ScrollView(.vertical, showsIndicators: false){
            ForEach(viewModel.postsList, id: \.id){
                post in
                PostCell(post: post, viewModel: viewModel)
                    .padding(10)
            }
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
