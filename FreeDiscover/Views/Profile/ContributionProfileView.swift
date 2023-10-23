//
//  ContributionProfileView.swift
//  FreeDiscover
//
//  Created by apprenant58 on 23/10/2023.
//

import SwiftUI

struct ContributionProfileView: View {
    let columns = [GridItem(.fixed(120)), GridItem(.fixed(120)),  GridItem(.fixed(120))]
    var user: UserProfile
    
    var body: some View {
        VStack {
            Profile_rectangle(userName: user.userName, userPicture: user.userPicture, userStatus: user.userStatus, userContribution: user.userContribution)
            
            ProfileSwitchButton()
                .padding()
            
            HStack {
//                ActivitySymbolSmall(activityType: "nature")
                Text("Mes activités proposées")
                    .font(.title2)
                    .padding(.trailing, 120.0)
            }
            ScrollView(.horizontal) {
            
                LazyVGrid(columns:columns) { content: do {
                    Image("calanque-en-vau")
                        .resizable()
                        .frame(width: 110, height: 110)
                    Image("jardin-borely")
                        .resizable()
                        .frame(width: 110, height: 110)
                    Image("plage-generique")
                        .resizable()
                        .frame(width: 110, height: 110)
                    Image("calanque-en-vau")
                        .resizable()
                        .frame(width: 110, height: 110)
                }
                }
            }
            .padding()
            Spacer()
        }
    }
}
        

#Preview {
    ContributionProfileView(user: UserProfile(userName: "Marion", userPicture: "marion", userStatus: "Serial discoverer", userContribution: 0, userPoints: 0))
}
