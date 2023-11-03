//
//  ActivityPreview.swift
//  FreeDiscover
//
//  Created by jerome julien on 26/10/2023.
//

import SwiftUI

struct ActivityPreview: View {
    @State var activity : FreeDiscover
    @EnvironmentObject var searchGlobalVariables : SearchGlobalVariables
    
    var body: some View {
        HStack(alignment:.top){
            VStack(alignment:.leading){
                NavigationLink(destination:ActivityDetailView(activity:activity))
                {
                    Text("\(activity.name)")
                        .font(.headline)
                }
                Text("12,7 km")
                    .font(.caption)
                HStack{
                    ActivitySymbolSmall(activityType: activity.type)
                    Spacer()
                    VoteCountDisplay2(activity: $activity)
                }
                Spacer()
                Text("\(activity.description)")
                    .font(.headline)
                    .fontWeight(.regular)
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                    .lineLimit(4)
                Spacer()

            }
            Spacer()
            ZStack(alignment : .topTrailing){
                Image("\(activity.image[0])")
                   .resizable()
                   .aspectRatio(contentMode: .fill)
                   .frame(width: 160, height: 160)
                   .clipShape(RoundedRectangle(cornerRadius: 8))
                FavoriteButton(activityId: activity.id)
            }
            
        }
        .padding()
        .presentationDetents([ .height(200)])
      // .presentationBackgroundInteraction(.enabled(upThrough: .height(200)))
        .presentationCornerRadius(20)
        .presentationDragIndicator(.visible)
    }
       
}

#Preview {
    ActivityPreview(activity: FreeDiscover.nature1)
        .environmentObject(UserGlobalVariables())
//        .environmentObject(ActivityGlobalVariables())
}
