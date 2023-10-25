//
//  CarrouselFavoriteEV.swift
//  FreeDiscover
//
//  Created by apprenant58 on 24/10/2023.
//

import SwiftUI

struct CarrouselFavoriteEV: View {
    var body: some View {
        HStack {
            ActivitySymbolSmall(activityType: "nature")
            Text("Nature")
                .font(.title2)
                .padding(.trailing, 100.0)
            Text("Ajouter une activité")
                .foregroundColor(.accentColor)
            Image(systemName:"plus.circle.fill")
                .foregroundColor(.accentColor)
        }
        ScrollView(.horizontal) {
            LazyHGrid(rows: [GridItem(.flexible())], content: {
                ForEach(getFavorite(),id: \.id){
                    favorite in
                Image("\(favorite.image)")
                    .resizable()
                    .frame(width: 140, height: 140)
                    .cornerRadius(10)
            }
//                Image("calanque-en-vau")
//                    .resizable()
//                    .frame(width: 140, height: 140)
//                    .cornerRadius(10)
//                Image("jardin-borely")
//                    .resizable()
//                    .frame(width: 140, height: 140)
//                    .cornerRadius(10)
//                Image("plage-generique")
//                    .resizable()
//                    .frame(width: 140, height: 140)
//                    .cornerRadius(10)
//                Image("calanque-en-vau")
//                    .resizable()
//                    .frame(width: 140, height: 140)
//                    .cornerRadius(10)
            })
        }
        
        .padding()
    }
}
