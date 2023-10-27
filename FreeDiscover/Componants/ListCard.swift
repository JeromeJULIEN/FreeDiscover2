//
//  ListCard.swift
//  FreeDiscover
//
//  Created by jerome julien on 19/10/2023.
//

import SwiftUI

struct ListCard: View {
    // activity to display
    var activity : FreeDiscover
    
    // bool to manage heart icon color (temp : will be define with the airtable DB)
    @State private var isFavorite : Bool = false
    
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
                    Text("\(activity.shortDescription)")
                        .font(.subheadline)
                        .fontWeight(.light)
                        .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    Text("12.4 km")
                        .font(.subheadline.weight(.light))
                        .foregroundColor(Color("GrayDark"))
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
                        VoteCountDisplay(voteCount: activity.voteCounter)
                    }
                  
                }
                .frame(height: 110)
                ZStack(alignment:.topTrailing) {
                    Image("\(activity.image)")
                       .resizable()
                       .aspectRatio(contentMode: .fill)
                       .frame(width: 110, height: 110)
                       .clipShape(RoundedRectangle(cornerRadius: 8))
                    Button(action : {isFavorite = !isFavorite}){
                        ZStack {
                            Image(systemName: "heart.fill")
                                .padding(4)
                                .foregroundStyle(.accent)
                                .opacity(isFavorite ? 1 : 0)
                                .bold()
                                .font(.title2)
                            Image(systemName: "heart")
                                .padding(4)
                                .foregroundStyle(.white)
                                .bold()
                                .font(.title2)
                        }
                        
                    }
                    
                }
            }
            .padding(10)
        }.padding(2)
    }
}

#Preview {
    ListCard(activity: FreeDiscover.nature1)
}
