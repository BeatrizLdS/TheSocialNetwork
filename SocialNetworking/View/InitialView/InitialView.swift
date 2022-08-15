//
//  InitialView.swift
//  SocialNetworking
//
//  Created by Beatriz Leonel da Silva on 11/08/22.
//

import SwiftUI

struct InitialView: View {
    
    @State private var showingLoginView : Bool = false
    @State private var showingRegisterView : Bool = false
    
    var body: some View {
        NavigationView{
            VStack{
                regirteUserButton
                loginUserButton
            }
            .sheet(isPresented: $showingRegisterView){
                RegisterView()
            }
            .sheet(isPresented: $showingLoginView){
                LoginView()
            }
        }
    }
    
    private var regirteUserButton : some View{
        Button{
            self.showingRegisterView = true
            print("Cadastrar usuário")
        }label: {
            Text("Cadastrar usuário")
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.regular)
    }
    
    private var loginUserButton : some View{
        Button{
            self.showingLoginView = true
            print("Entrar com usuário")
        }label: {
            Text("Entrar")
        }
    }
}

struct InitialView_Previews: PreviewProvider {
    static var previews: some View {
        InitialView()
    }
}
