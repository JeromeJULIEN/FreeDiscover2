//
//  Profile.swift
//  FreeDiscover
//
//  Created by jerome julien on 19/10/2023.
//

import SwiftUI

struct ProfileView: View {
   @State var activityType: ActivityTypes = .nature
    
//    @EnvironmentObject var userGlobalVariables : UserGlobalVariables
    var user: User
    
    var body: some View {
        VStack {
            Profile_rectangle(user : user)
            ProfileSwitchButton()
                .padding()
            ScrollView {
                ForEach(ActivityTypes.allCases, id:\.self) { activity in
                    HStack {
                        ActivitySymbolSmall(activityType: activity.rawValue)
                        .padding(.leading)
                        Text(activity.rawValue.capitalized)
                        Spacer()
                    }
                    CarrouselFavoriteEV(activityType: activity.rawValue, user : user)
                }
            }
        }
    }
}

#Preview {
    ProfileView(activityType: .nature, user: User.marion)
}



