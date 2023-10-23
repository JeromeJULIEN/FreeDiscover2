//
//  HomepageViewJeromeTest.swift
//  FreeDiscover
//
//  Created by jerome julien on 20/10/2023.
//

import SwiftUI
import MapKit

struct HomepageView: View {
    var body: some View {
        NavigationView{
            ZStack{
                //map
                Map()
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
                    CarrousselBonPlan()
                }
            }

        }
    }
}

#Preview {
    HomepageView()
}
