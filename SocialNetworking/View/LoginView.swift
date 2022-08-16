//
//  LoginView.swift
//  SocialNetworking
//
//  Created by Beatriz Leonel da Silva on 16/08/22.
//

import SwiftUI

struct LoginView: View {
    
    @State private var emailText : String = ""
    @State private var passwordText : String = ""
    
    var body: some View {
        NavigationView{
            VStack (alignment: .center, spacing: 20) {
                informationView
                loginButtonView
                
            }
            .navigationBarTitle("Login", displayMode: .inline)
            .padding(20)
        }
    }
    
    private var informationView: some View{
        VStack (alignment: .center, spacing: 5){
            TextField("Email", text: $emailText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            SecureField("Senha", text: $passwordText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
    
    private var loginButtonView: some View{
        Button{
        }label:{
            Text("Entrar")
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.regular)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
