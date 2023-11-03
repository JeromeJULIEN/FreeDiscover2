//
//  ContributionProfileView.swift
//  FreeDiscover
//
//  Created by apprenant58 on 23/10/2023.
//

import SwiftUI

struct ContributionProfileView: View {
  
    var user: User
    
    var body: some View {
        VStack {
            Profile_rectangle(user: user )
            
            ProfileSwitchButton()
                .padding()
            ScrollView {
                ForEach(ActivityTypes.allCases, id:\.self) { activity in
                    HStack { ActivitySymbolSmall(activityType: ActivityTypes(rawValue: activity.rawValue) ?? .nature)
                            .padding(.leading)
                        Text(activity.rawValue.capitalized)
                        Spacer()
                    }
                    CarrouselContributionEV(activityType: activity, user : user) }
            }
            
            .padding()
            Spacer()
        }
    }
}
        

//#Preview {
//    ContributionProfileView(user: UserProfile(id: 1, userName: "Marion", userPicture: "marion",  userContributions: [1,2] ))
//}
