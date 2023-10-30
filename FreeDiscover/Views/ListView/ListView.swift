//
//  ListView.swift
//  FreeDiscover
//
//  Created by jerome julien on 19/10/2023.
//

import SwiftUI

struct ListView: View {
    var body: some View {
        VStack(spacing:15){
            Spacer().frame(height: 60)
            ForEach(FreeDiscover.allFreeDiscover){activity in
                NavigationLink(destination:ActivityDetailView(activity: activity)){
                    ListCard(activity: activity)
                }.accentColor(Color("GrayDark"))
            }
        }
        .padding()
    }
}
               

#Preview {
    ListView()
}
