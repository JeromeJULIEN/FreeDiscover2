//
//  Profile.swift
//  FreeDiscover
//
//  Created by jerome julien on 19/10/2023.
//

import SwiftUI

struct ProfileView: View {
   @State var activityType: ActivityTypes = .nature
    @State private var currentMode: ProfileViewMode = .favorite
//    @EnvironmentObject var userGlobalVariables : UserGlobalVariables
    var user: UserProfile
    
    var body: some View {
        VStack {
            Profile_rectangle(userName: user.userName, userPicture: user.userPicture,  userContribution: user.userContributions.count)
            ProfileSwitchButton()
                .padding()
            if (currentMode == .favorite){
                ScrollView {
                    ForEach(ActivityTypes.allCases, id:\.self) { activity in
                        HStack { ActivitySymbolSmall(activityType: ActivityTypes(rawValue: activity.rawValue) ?? .nature)
                                .padding(.leading)
                            Text(activity.rawValue.capitalized)
                                .font(.title2)
                            Spacer()
                        }
                        //                        if (currentMode == .favorite){
                        CarrouselFavoriteEV(activityType: activity, user : user) }
                } }
            else {
                ScrollView {
                    ForEach(ActivityTypes.allCases, id:\.self) { activity in
                        HStack { ActivitySymbolSmall(activityType: ActivityTypes(rawValue: activity.rawValue) ?? .nature)
                                .padding(.leading)
                            Text(activity.rawValue.capitalized)
                            Spacer()
                        }
                        CarrouselContributionEV(activityType: activity, user : user) }
                }
            }
        }
    }
}

#Preview {
    ProfileView(activityType: .nature, user: UserProfile.marion)
}



