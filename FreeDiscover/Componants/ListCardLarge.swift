//
//  ListCardLarge.swift
//  FreeDiscover
//
//  Created by apprenant92 on 02/11/2023.
//

import SwiftUI

struct ListCardLarge: View {
    @State var activity : FreeDiscover
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 12)
                .frame(height: 220)
                .foregroundColor(.white)
                .shadow(radius: 2)
            VStack {
                Text("\(activity.name)")
                    .font(.title3.bold())
                  //  .padding()
                HStack{
                    
                    VStack(alignment: .leading, spacing: 0){
                        
                        // .padding()
                        
                        Text("\(activity.description)")
                            .font(.caption)
                            .fontWeight(.light)
                            .lineLimit(4)
                            .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                            .padding()
                        Text("12.4 km")
                            .font(.subheadline.weight(.light))
                            .foregroundColor(Color.grayDark)
                        Spacer()
                        HStack{
                            ActivitySymbolSmall(activityType: activity.type)
                            if(activity.family){
                                Image(systemName: "figure.2.and.child.holdinghands")
                                    .foregroundColor(.grayDark)
                            }
                            if(activity.accessibiliy){
                                Image(systemName: "figure.roll")
                                    .foregroundColor(.grayDark)
                            }
                            if(activity.temporary){
                                Image(systemName: "calendar")
                                    .foregroundColor(.grayDark)
                            }
                            Spacer()
                            VoteCountDisplay2(activity: $activity)
                        }
                        
                    }
                    .frame(height: 180)
                    ZStack(alignment:.topTrailing) {
                        Image("\(activity.image[0])")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 150, height: 150)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        FavoriteButton(activityId: activity.id)
                        
                        
                    }
                }
            }
            .padding(10)
        }.padding(2)
    }
}

#Preview {
    ListCardLarge(activity: FreeDiscover.musee1).environmentObject(UserGlobalVariables())
}

