//
//  Profile rectangle.swift
//  FreeDiscover
//
//  Created by apprenant58 on 20/10/2023.
//

import SwiftUI

struct Profile_rectangle: View {
    var user : User
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 360, height: 160)
                .foregroundColor(.white)
                .shadow(radius: 8)
            
            
            HStack {
                if let imageFound = user.userPicture.first {
                    AsyncImage(url: URL(string: imageFound.url)) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFill()
                        } else if phase.error != nil {
                            Text("Image indisponible")
                        } else {
                            ProgressView()
                        }
                    }
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: 100)
                   .clipShape(RoundedRectangle(cornerRadius: 8))
                   .padding()
                }
                VStack(alignment: .leading) {
                    Text("\(user.name)")
                        .foregroundColor(.accentColor)
                        .fontWeight(.bold)
                        .font(.title)
                    HStack {
                        Text("userStatus à calculer")
                        Image(systemName: "laurel.leading")
//                        récupérer le logo sur page de Flo à la place . Puis après voir pour le lier au nombre de contribution
                        
                    }
                    Text("\(user.activities.count) contributions")
                            
                            .foregroundColor(.gray)
                        .padding(.top, 10)
                     
                    NavigationLink(destination: CreateActivityView(currentCategory: .nature, isTemporary: true)){
                        HStack {
                            Image(systemName:"plus.circle.fill")
                                .foregroundColor(.gray)
                                .fontWeight(.light)
                            Text("Ajouter une activité")
                                .foregroundColor(.gray)
                            
                        }
                    }
//                    ZStack {
//                        RoundedRectangle(cornerRadius: 10)
//                            .frame(width: 160, height: 44)
//                            .foregroundColor(.grayLight)
//                        Text("Ajouter une contribution")
//                            .fontWeight(.bold)
//                            .foregroundColor(.accentColor)
//                    }
                }
                .padding()
            }
        }
        .padding()
    }
}
#Preview {
    Profile_rectangle(user : User.marion)
}
