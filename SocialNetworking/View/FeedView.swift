//
//  ContentView.swift
//  SocialNetworking
//
//  Created by Beatriz Leonel da Silva on 10/08/22.
//

import SwiftUI
import CoreData

struct FeedView: View {
    
    @Environment(\.dismiss) private var dismiss
    
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
                        Task{
                            if (await viewModel.logOut()){
                                dismiss()
                            }
                        }
                    }label: {
                        Text("LogOut")
                    }
                }
            }
        }
    }
    var emptyStateView: some View {
        VStack {
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


struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}