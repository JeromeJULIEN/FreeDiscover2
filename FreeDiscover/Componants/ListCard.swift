//
//  ListCard.swift
//  FreeDiscover
//
//  Created by jerome julien on 19/10/2023.
//

import SwiftUI

struct ListCard: View {
    var title : String
    var shortDescription : String
    var activityType : String
    var voteCount :Int
    var imageName : String
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 12)
                .frame(height: 130)
                .foregroundColor(.white)
                .shadow(radius: 2)
            HStack{
                VStack(alignment: .leading, spacing: 0){
                    Text("\(title)")
                        .font(.title3.bold())
                    Text("\(shortDescription)")
                        .font(.subheadline)
                        .fontWeight(.light)
                        .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    Text("12.4 km")
                        .font(.subheadline.weight(.light))
                        .foregroundColor(Color("GrayDark"))
                    Spacer()
                    HStack{
                        ActivitySymbolSmall(activityType: "\(activityType)")
                        Spacer()
                        VoteCountDisplay(voteCount: voteCount)
                    }
                  
                }
                .frame(height: 110)
                Image("\(imageName)")
                   .resizable()
                   .aspectRatio(contentMode: .fill)
                   .frame(width: 110, height: 110)
                   .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .padding(10)
        }.padding(2)
    }
}

#Preview {
    ListCard(title : "Calanque d'en Vau",shortDescription: "Calanque grandiose, eaux turquoise.", activityType: "nature",voteCount: 10,imageName: "calanque-en-vau")
}
