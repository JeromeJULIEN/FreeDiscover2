//
//  ActivityPreview.swift
//  FreeDiscover
//
//  Created by jerome julien on 26/10/2023.
//

import SwiftUI

struct ActivityPreview: View {

    @State var activity : Activity
    var distanceToUser : Double {calculateDistance(lat1: 43.296367, lon1: 5.368363, lat2: activity.latitude, lon2: activity.longitude)}


    @EnvironmentObject var searchGlobalVariables : SearchGlobalVariables

    
    var body: some View {
        HStack(alignment:.top){
            VStack(alignment:.leading){
                NavigationLink(destination:ActivityDetailView(activity:activity))
                {
                    Text("\(activity.name)")
                        .font(.headline)
                }
                Text("\(distanceToUser, specifier: "%.1f") km")
                    .font(.caption)
                HStack{
                    ActivitySymbolSmall(activityType: activity.typeActivite)
                    Spacer()
                    //VoteCountDisplay2(activity: $activity)
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
                if let imageFound = activity.photos.first {
                    AsyncImage(url: URL(string: imageFound.url)) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFill()
                        } else if phase.error != nil {
                            Text("Image indisponible")
                        } else {
                            ProgressView()
                        }
                    }
                   .frame(width: 110, height: 110)
                   .clipShape(RoundedRectangle(cornerRadius: 8))
                }
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
    ActivityPreview(activity: Activity.nature1)
        .environmentObject(APIUserRequestModel())
//        .environmentObject(ActivityGlobalVariables())
}
