//
//  RegisterView.swift
//  SocialNetworking
//
//  Created by Beatriz Leonel da Silva on 11/08/22.
//

import SwiftUI

struct RegisterView: View {
    
    @State private var nameText : String = ""
    @State private var emailText : String = ""
    @State private var passwordText : String = ""
    @State private var passwordConfirmationText : String = ""
    
    var body: some View {
        VStack (alignment: .trailing, spacing: 5) {
            TextField("Nome", text: $nameText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Email", text: $emailText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Senha", text: $passwordText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Confirmação de Senha", text: $passwordConfirmationText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
       

        
    }
    
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
