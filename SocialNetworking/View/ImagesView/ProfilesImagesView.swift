//
//  ProfilesImagesView.swift
//  SocialNetworking
//
//  Created by Beatriz Leonel da Silva on 11/08/22.
//

import SwiftUI

struct ProfileDefaultImageView: View {
    
    var body: some View {
        Image(systemName: "person.fill")
            .renderingMode(.original)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding()
            .frame(width: 120, height: 120)
            .clipShape(Circle())
    }
    
}

struct ProfilesImagesView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileDefaultImageView()
    }
}
