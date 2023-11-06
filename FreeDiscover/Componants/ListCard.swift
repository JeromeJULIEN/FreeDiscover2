//
//  ListCard.swift
//  FreeDiscover
//
//  Created by jerome julien on 19/10/2023.
//

import SwiftUI

struct ListCard: View {
    // activity to display
    @State var activity : Activity
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 12)
                .frame(height: 130)
                .foregroundColor(.white)
                .shadow(radius: 2)
            HStack{
                VStack(alignment: .leading, spacing: 0){
                    Text("\(activity.name)")
                        .font(.title3.bold())
                    Text("\(activity.description)")
                        .font(.subheadline)
                        .fontWeight(.light)
                        .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                        .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                    Text("12.4 km")
                        .font(.subheadline.weight(.light))
                        .foregroundColor(Color("GrayDark"))
                    Spacer()
                    HStack{
                        ActivitySymbolSmall(activityType: activity.typeActivite)
                        if(activity.famille == "true"){
                            Image(systemName: "figure.2.and.child.holdinghands")
                                .foregroundColor(.grayDark)
                        }
                        if(activity.accessibilite == "true"){
                            Image(systemName: "figure.roll")
                                .foregroundColor(.grayDark)
                        }
                        if(activity.temporaire == "true"){
                            Image(systemName: "calendar")
                                .foregroundColor(.grayDark)
                        }
                        Spacer()
                        VoteCountDisplay2(activity: $activity)
                    }
                  
                }
                .frame(height: 110)
                ZStack(alignment:.topTrailing) {
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
            .padding(10)
        }.padding(2)
    }
}

#Preview {
    ListCard(activity: Activity.nature1).environmentObject(APIUserRequestModel())
}
