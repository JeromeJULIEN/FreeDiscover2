//
//  Profile.swift
//  FreeDiscover
//
//  Created by jerome julien on 19/10/2023.
//

import SwiftUI

struct ProfileView: View {
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
        }
    }
}

#Preview {
    ProfileView(user: UserProfile(userName: "Marion", userPicture: "marion", userStatus: "Serial discoverer", userContribution: 0, userPoints: 0))
}



