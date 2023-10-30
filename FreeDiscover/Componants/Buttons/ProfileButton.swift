//
//  ProfilSymbol.swift
//  FreeDiscover
//
//  Created by apprenant 101 on 23/10/2023.
//

/*
 Abstract:
 `ProfilSymbol` ReprÃ©sente le symbol du profil qui est placer sur la carte pour l'ouverture de la vue profil.
 */

import SwiftUI

struct ProfileButton: View {
    @Binding var showCarroussel : Bool
    
    var body: some View {
        NavigationLink(destination: ProfileView(user: UserProfile(userName: "Marion", userPicture: "marion", userStatus: "Serial Discoverer", userContribution: 13, userPoints: 0))){
            Image(systemName: "person")
                .imageScale(.large)
                .padding(10)
                .foregroundStyle(.white)
                .background(Color.accentColor, in: Circle())
                .shadow(color: Color.secondary, radius: 4)
        }
        .simultaneousGesture(TapGesture().onEnded{
            showCarroussel = false
        })
    }
}

#Preview {
    ProfileButton(showCarroussel: .constant(false))
}
