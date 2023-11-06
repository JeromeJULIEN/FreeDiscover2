//
//  CarrouselFavoriteEV.swift
//  FreeDiscover
//
//  Created by apprenant58 on 24/10/2023.
//

import SwiftUI

struct CarrouselFavoriteEV: View {
    
    @EnvironmentObject var activityGlobalVariable : APIActivityRequestModel
    
    var activityType : String
    var user : User
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
                    ForEach(getFavoriteFromUserByType(activityDataBase: activityGlobalVariable.allActivities, userFavorites: user.idFromFavorite, type: activityType),id: \.id){
                        favorite in
                        NavigationLink(destination:ActivityDetailView(activity: favorite)) {
                            VStack {
                                
                                if let imageFound = favorite.photos.first {
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
                                    .frame(width:140,height: 140)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                }
                                Text("\(favorite.name)")
                                    .frame(width:120,height: 50)
                                    .multilineTextAlignment(.center)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .accentColor(Color("GrayDark"))
                            }
                    }
                }
            })
        }
        .padding()

                    Divider()
    }
}

#Preview {
    CarrouselFavoriteEV(activityType: "nature", user: User.marion)
}
