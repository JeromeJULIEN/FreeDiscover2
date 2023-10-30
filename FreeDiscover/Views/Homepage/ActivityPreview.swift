//
//  ActivityPreview.swift
//  FreeDiscover
//
//  Created by jerome julien on 26/10/2023.
//

import SwiftUI

struct ActivityPreview: View {
    var activity : FreeDiscover
    
    var body: some View {
        HStack(alignment:.top){
            VStack(alignment:.leading){
                Text("\(activity.name)")
                    .font(.headline)
                Text("12,7 km")
                    .font(.caption)
                HStack{
                    ActivitySymbolSmall(activityType: activity.type)
                    Spacer()
                    VoteCountDisplay(voteCount: activity.voteCounter)
                }
                Spacer()
                Text("\(activity.shortDescription)")
                    .font(.headline)
                    .fontWeight(.regular)
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                    .lineLimit(4)
                Spacer()

            }
            Spacer()
            Image("\(activity.image)")
               .resizable()
               .aspectRatio(contentMode: .fill)
               .frame(width: 160, height: 160)
               .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .padding()
        .presentationDetents([ .height(200)])
        .presentationBackgroundInteraction(.enabled(upThrough: .height(200)))
        .presentationCornerRadius(20)
        .presentationDragIndicator(.visible)
    }
       
}

#Preview {
    ActivityPreview(activity: FreeDiscover.nature1)
}
