//
//  ListView.swift
//  FreeDiscover
//
//  Created by jerome julien on 19/10/2023.
//

import SwiftUI

struct ListView: View {
    var body: some View {
        NavigationView{
            ZStack{
                // Activity scrolling list
                ScrollView{
                    VStack(spacing:15){
                        Spacer().frame(height: 60)
                        ForEach(FreeDiscover.allFreeDiscover){activity in
                            NavigationLink(destination:ActivityDetailView()){
                                ListCard(title:activity.name,shortDescription: activity.shortDescription,activityType: activity.type.rawValue,voteCount: activity.voteCounter,imageName: activity.image)
                            }.accentColor(Color("GrayDark"))
                        }
                    }
                }
                // Fixed button on the top
                VStack {
                    HStack{
                        SearchButton()
                        Spacer()
                        DisplaySwitchButton()
                        Spacer()
                        ProfileButton()
                    }
                    .padding(.bottom)
                    .background(.white)
                    Spacer()
                }
            }
            .padding()
        }
        
    }
}

#Preview {
    ListView()
}
