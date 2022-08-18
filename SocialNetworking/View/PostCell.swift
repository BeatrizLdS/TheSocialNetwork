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
    let post : Post
    @State var userName : String = ""
    
    init(post: Post, viewModel : PostViewModel){
        self.post = post
        self.viewModel = viewModel
    }
    
    var body: some View{
        VStack(alignment: .leading, spacing: 5) {
            
            Text(userName).bold()
                .frame(width: UIScreen.main.bounds.width - 100)
            
            
            if post.media != nil{
                AsyncImage(url: URL(string: "http://adaspace.local/" + post.media!) ) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.width - 100)
                        .clipped()
                } placeholder: {
                    Color.yellow.opacity(1)
                }
                .frame(width: UIScreen.main.bounds.width - 100)
                
                Spacer()
            }
            
            Text(post.content)
                .frame(width: UIScreen.main.bounds.width - 100, alignment: .leading)
            
            Text(String(post.likeCount) + " likes")
                .foregroundColor(.secondary)
            

                
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
    
    
}

//struct PostCell_Previews: PreviewProvider {
//    static var previews: some View {
//        PostCell(post: Post(id: "id", media: nil, content: "Meu texto", likeCount: 10, userId: "beatrizID", createdAt: "dataCriada", updatedAt: "dataAtualizada"))
//    }
//}
