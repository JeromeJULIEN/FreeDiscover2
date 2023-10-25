//
//  ContributionProfileView.swift
//  FreeDiscover
//
//  Created by apprenant58 on 23/10/2023.
//

import SwiftUI

struct ContributionProfileView: View {
  
    var user: UserProfile
    
    var body: some View {
        VStack {
            Profile_rectangle(userName: user.userName, userPicture: user.userPicture, userStatus: user.userStatus, userContribution: user.userContribution)
            
            ProfileSwitchButton()
                .padding()
            
            ScrollView {
                CarrouselFavoriteEV()
                CarrouselFavoriteEV()
                CarrouselFavoriteEV()
                CarrouselFavoriteEV()
            }
            
            .padding()
            Spacer()
        }
    }
}
        

#Preview {
    ContributionProfileView(user: UserProfile(userName: "Marion", userPicture: "marion", userStatus: "Serial discoverer", userContribution: 0, userPoints: 0))
}
