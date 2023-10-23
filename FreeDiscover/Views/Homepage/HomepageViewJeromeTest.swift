//
//  HomepageViewJeromeTest.swift
//  FreeDiscover
//
//  Created by jerome julien on 20/10/2023.
//

import SwiftUI
import MapKit

struct HomepageViewJeromeTest: View {
    var body: some View {
        NavigationView{
            ZStack{
                //map
                Map()
//                Map{
//                    ForEach(FreeDiscover.allFreeDiscover){activity in
//                        Marker("\(activity.name)",coordinate: activity.location)
//                    }
//                }
                // Fixed button on the top
                VStack {
                    HStack{
                        SearchButton()
                        Spacer()
                        DisplaySwitchButton()
                        Spacer()
                        ProfileButton()
                    }
                    .padding()
                    Spacer()
                }
            }

        }
    }
}

#Preview {
    HomepageViewJeromeTest()
}

