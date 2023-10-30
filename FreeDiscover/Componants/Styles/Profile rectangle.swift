//
//  Profile rectangle.swift
//  FreeDiscover
//
//  Created by apprenant58 on 20/10/2023.
//

import SwiftUI

struct Profile_rectangle: View {
    var userName: String
    var userPicture: String
    var userStatus: String
    var userContribution: Int
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 360, height: 160)
                .foregroundColor(.white)
                .shadow(radius: 8)
            
            
            HStack {
                Image(userPicture)
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray)
                    .padding()
                VStack(alignment: .leading) {
                    Text(userName)
                        .foregroundColor(.accentColor)
                        .fontWeight(.bold)
                        .font(.title)
                    HStack {
                        Text(userStatus)
                        Image(systemName: "laurel.leading")
//                        récupérer le logo sur page de Flo à la place . Puis après voir pour le lier au nombre de contribution
                        
                    }
                        Text("\(userContribution) contributions")
                            
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
    Profile_rectangle(userName: "Marion", userPicture: "marion", userStatus: "Serial Discoverer", userContribution: 0)
}
