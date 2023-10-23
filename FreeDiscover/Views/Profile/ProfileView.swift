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
            HStack {
                ActivitySymbolSmall(activityType: "nature")
                Text("Nature")
                    .font(.title2)
                    .padding(.trailing, 240.0)
            }
            ScrollView(.horizontal) {
                LazyHGrid(rows: [GridItem(.flexible())], content: {
                    Image("calanque-en-vau")
                        .resizable()
                        .frame(width: 140, height: 140)
                    Image("jardin-borely")
                        .resizable()
                        .frame(width: 140, height: 140)
                    Image("plage-generique")
                        .resizable()
                        .frame(width: 140, height: 140)
                    Image("calanque-en-vau")
                        .resizable()
                        .frame(width: 140, height: 140)
                })
            }
            
            .padding()
            Spacer()
        }
    }
}


#Preview {
    ProfileView(user: UserProfile(userName: "Marion", userPicture: "marion", userStatus: "Serial discoverer", userContribution: 0, userPoints: 0))
}

