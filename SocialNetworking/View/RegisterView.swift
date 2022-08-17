//
//  RegisterView.swift
//  SocialNetworking
//
//  Created by Beatriz Leonel da Silva on 11/08/22.
//

import SwiftUI

struct RegisterView: View {
    
    @ObservedObject var userViewModel : UserViewModel = UserViewModel()
    
    @State private var messageError : String = ""
    
    @State private var nameText : String = ""
    @State private var emailText : String = ""
    @State private var passwordText : String = ""
    @State private var passwordConfirmationText : String = ""
    @State private var avatarText: String = ""
    
    var body: some View {
        NavigationView{
            VStack (alignment: .center, spacing: 20) {
                informationView
                Text(messageError)
                    .foregroundColor(.red)
                createButtonView
            }
            .navigationBarTitle("Cadastrar novo usuário", displayMode: .inline)
            .padding(20)
        }
    }
    
    private var informationView: some View{
        VStack (alignment: .center, spacing: 5){
            TextField("Nome", text: $nameText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Email", text: $emailText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            SecureField("Senha", text: $passwordText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            SecureField("Confirmação de Senha", text: $passwordConfirmationText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
    
    
    // MARK: código do avatar
    private var imageProfileView : some View{
        VStack (alignment: .center, spacing: 1){
            Image(systemName: "person.fill")
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
                .frame(width: 120, height: 120)
                .clipShape(Circle())
            changePhotoButtonView
        }
    }
    
    private var changePhotoButtonView : some View {
            Button{
                print("Procurar imagem de perfil")
            }label: {
                ZStack{
                    Label("Trocar Imagem", systemImage: "camera.fill")
                        .imageScale(.large)
                    
                }
            }
            .labelStyle(.iconOnly)
            .buttonStyle(.bordered)
            .clipShape(Circle())
            .dynamicTypeSize(.large)
        }
    
    private var createButtonView : some View{
        Button{
            Task{
                
                if (nameText == "" || emailText == "" || passwordText == "" || passwordConfirmationText == ""){
                    messageError = "Preencha todos os campos"
                } else{
                    let returned = await userViewModel.checkUser(name: nameText,
                                            email: emailText,
                                            password: passwordText,
                                            passwordConfirmation: passwordConfirmationText)
                    print(returned)
                    if !returned {
                        messageError = "Senha incorreta ou Email já está cadastrado"
                    }
                }
            }
            
        }label:{
            Text("Criar usuário")
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.regular)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
