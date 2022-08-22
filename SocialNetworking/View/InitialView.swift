//
//  InitialView.swift
//  SocialNetworking
//
//  Created by Beatriz Leonel da Silva on 16/08/22.
//

import SwiftUI

struct InitialView: View {
    
    @State private var showingRegisterView : Bool = false
    @State private var showingLoginView : Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                registerButton
                loginButton
            }
            .sheet(isPresented: $showingRegisterView){
                RegisterView()
            }
            .sheet(isPresented: $showingLoginView){
                LoginView()
            }
        }
    }
    
    private var registerButton : some View {
        Button{
            self.showingRegisterView = true
        }label: {
            Text("Cadastrar")
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.regular)
    }
    
    private var loginButton : some View {
        Button{
            self.showingLoginView = true
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
