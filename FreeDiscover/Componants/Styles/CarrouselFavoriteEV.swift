//
//  CarrouselFavoriteEV.swift
//  FreeDiscover
//
//  Created by apprenant58 on 24/10/2023.
//

import SwiftUI

struct CarrouselFavoriteEV: View {
  var activityType : ActivityTypes
    var user : UserProfile
    var body: some View {
        HStack {
//            ActivitySymbolSmall(activityType: .culture)
//            Text(activityType.rawValue)
//                .font(.title2)
//                .padding(.trailing, 100.0)
//            Text("Ajouter une activité")
//                .foregroundColor(.accentColor)
//            Image(systemName:"plus.circle.fill")
//                .foregroundColor(.accentColor)
        }
        ScrollView(.horizontal) {
            LazyHGrid(rows: [GridItem(.flexible())], content: {
                ForEach(getFavoriteFromUserByType(userFavorites: user.userFavorites, type: activityType),id: \.id){
                    favorite in
                Image("\(favorite.image[0])")
                    .resizable()
                    .frame(width: 140, height: 140)
                    .cornerRadius(10)
                }
            })
        }
        .padding()

                    Divider()
    }
}

#Preview {
    CarrouselFavoriteEV(activityType: .nature, user: UserProfile.marion)
}
