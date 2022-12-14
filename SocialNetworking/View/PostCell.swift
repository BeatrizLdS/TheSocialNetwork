//
//  PostCell.swift
//  SocialNetworking
//
//  Created by Beatriz Leonel da Silva on 11/08/22.
//

import Foundation
import SwiftUI

struct PostCell: View{
    
    @ObservedObject var viewModel: PostViewModel
    
    @State var post : Post
    @State var userName : String = ""
    @State var favorite : Bool 
    
    init(post: Post, viewModel : PostViewModel, favorite: Bool){
        self.post = post
        self.viewModel = viewModel
        self.favorite = favorite
    }
    
    var body: some View{
        VStack(alignment: .leading, spacing: 10) {
            
            Text(userName).bold()
                .frame(width: UIScreen.main.bounds.width - 80, alignment: .leading)
            
            if post.media != nil{
                AsyncImage(url: URL(string: "http://adaspace.local/" + post.media!) ) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width - 80, height: UIScreen.main.bounds.width - 80)
                        .clipped()
                } placeholder: {
                    Color.yellow.opacity(1)
                }
                .frame(width: UIScreen.main.bounds.width - 80)
                
                Spacer()
            }
            
            Text(post.content)
                .font(.subheadline)
                .frame(width: UIScreen.main.bounds.width - 80, alignment: .leading)
        
            favoriteButton
                
        }
        .task {
            userName = await viewModel.findUserName(id: post.userId)
            if userName == ""{
                userName = "Sem nome de perfil"
            }
        }
        .padding()
        .background(.gray.opacity(0.25))
        .cornerRadius(20)
            
    }
    
    private var favoriteButton : some View {
        Button{
            Task{
                print(favorite)
                if !favorite {
                    if let post = await viewModel.addLikeToPost(postID: post.id){
                        self.post = post
                        favorite.toggle()
                    }
                } else {
                    if await viewModel.removeLikeToPost(postID: post.id){
                        if let post = await viewModel.updatePost(postID: post.id){
                            self.post = post
                            favorite.toggle()
                        }
                    }
                }
                
            }
            
        } label: {
            HStack (spacing: 2){
                ZStack {
                    Image(systemName: "heart")
                        .font(.system(size: 20))
                    Image(systemName: "heart.fill")
                        .font(.system(size: 20))
                        .opacity(favorite ? 1 : 0)
                }
                .foregroundColor(favorite ? .pink : .black)
                
                Text(String(post.likeCount) + " likes")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .frame(height: 30, alignment: .leading)
            
        }
    }
    
}

struct PostCell_Previews: PreviewProvider {
    static var previews: some View {
        PostCell(post: Post(id: "F26FA5D1-3C02-4E66-A88F-326A415F11DC",
                            media: nil,
                            content: "Esse ?? um texto aleat??rio para eu testar como a c??lula de posts est?? ficando visualmente",
                            likeCount: 1000,
                            userId: "F26FA5D1-3C02-4E66-A88F-326A415F11DC",
                            createdAt: "Data de inicio",
                            updatedAt: "Data que foi atualizada") ,
                 viewModel: PostViewModel(),
                 favorite: true)
    }
}
