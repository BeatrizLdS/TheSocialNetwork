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
    
    @State var postText : String = ""

    var body: some View {
        NavigationView{
            ZStack{
                if viewModel.postsList.isEmpty {
                    emptyStateView
                } else {
                    VStack{
                        addPostArea
                        postsListView
                        Spacer()
                    }
                    
                }
            }
            .task{
                await viewModel.fetchPosts()
            }
            .navigationBarTitle("Feed", displayMode: .inline)
            .toolbar{
                ToolbarItem(placement: .primaryAction){
                    logoutButton
                }
//                ToolbarItem(placement: .bottomBar){
//                    addPostButton
//                }
            }
        }
    }
    
    private var logoutButton : some View {
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
    
    private var addPostArea: some View {
        HStack{
            TextField("Escreva aqui", text: $postText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button {
                Task{
                    if await viewModel.addPosts(postText: self.postText){
                        self.postText = ""
                    }
                }
            } label: {
                Label("Publicar", systemImage: "paperplane.fill")
                    .labelStyle(.iconOnly)
            }
            .controlSize(.large)
        }
        
        .padding()
        .background(.gray.opacity(0.5))
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
