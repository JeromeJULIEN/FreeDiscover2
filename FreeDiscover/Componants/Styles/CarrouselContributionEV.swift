//
//  CarrouselContributionEV.swift
//  FreeDiscover
//
//  Created by apprenant58 on 02/11/2023.
//


import SwiftUI

struct CarrouselContributionEV: View {
    
    @EnvironmentObject var activityGlobalVariable : APIActivityRequestModel

    
  var activityType : String
    var user : User
    var body: some View {
        HStack {

        }
        ScrollView(.horizontal) {
            LazyHGrid(rows: [GridItem(.flexible())], content: {
                ForEach(getContributionFromUserByType(activityDataBase: activityGlobalVariable.allActivities, userContribution: user.idFromActivities, type: activityType),id: \.id){
                    favorite in
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
                }
            })
        }
        .padding()

                    Divider()
    }
}

#Preview {
    CarrouselFavoriteEV(activityType: "nature", user: User.marion).environmentObject(APIActivityRequestModel())
}
