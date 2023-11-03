//
//  CarrouselContributionEV.swift
//  FreeDiscover
//
//  Created by apprenant58 on 02/11/2023.
//


import SwiftUI

struct CarrouselContributionEV: View {
  var activityType : ActivityTypes
    var user : UserProfile
    var body: some View {
        HStack {

        }
        ScrollView(.horizontal) {
            LazyHGrid(rows: [GridItem(.flexible())], content: {
                ForEach(getContribution(userContributions: user.userContributions, type: activityType),id: \.id){
                    contributions in
                Image("\(contributions.image[0])")
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
