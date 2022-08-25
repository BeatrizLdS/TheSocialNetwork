//
//  LoginView.swift
//  SocialNetworking
//
//  Created by Beatriz Leonel da Silva on 16/08/22.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var userViewModel : UserViewModel
    
    @State private var messageError : String = ""
    
    @State private var emailText : String = "beatrizleonel@gmail.com"
    @State private var passwordText : String = "senhaforte"
    
    @State private var isSigningIn : Bool = false
    
    
    var body: some View {
        NavigationView{
            VStack (alignment: .center, spacing: 20) {
                formsView
                Text(messageError)
                    .foregroundColor(.red)
                loginButtonView
                
            }
            .navigationBarTitle("Login", displayMode: .inline)
            .padding(20)
            .fullScreenCover(isPresented: $isSigningIn){
                FeedView(viewModel: PostViewModel())
            }
        }
    }
    
    private var formsView: some View{
        VStack (alignment: .center, spacing: 5){
            TextField("Email", text: $emailText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            SecureField("Senha", text: $passwordText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
    
    private var loginButtonView: some View{
        Button{
            Task{
                if (emailText == "" || passwordText == ""){
                    messageError = "Preencha todos os campos"
                }else{
                    userViewModel.checkLogin(email: emailText,
                                             password: passwordText,
                                             completion: {
                                                             returned in
                                                                if returned == false{
                                                                    messageError = "Email e/ou senha estão incorretos."
                                                                } else{
                                                                    isSigningIn = true
                                                                }
                                                        })
                }
            }
        }label:{
            Text("Entrar")
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.regular)
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
