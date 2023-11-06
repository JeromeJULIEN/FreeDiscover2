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
                        .multilineTextAlignment(.leading)
                        .font(.title3.bold())
                        .fixedSize(horizontal: false, vertical: true)
                    if(activity.temporaire == "true"){
                            if activity.dateDeDebut == activity.dateDeFin {
                                
                            if let date = dateFormatter.date(from: activity.dateDeDebut) {
                                let frenchDate = formatDateInFrench(date)
                                Text("Date : \(frenchDate)")
                                    
                            } else {
                                Text("Date invalide")
                            }
                            }
                            else {
                                if let dateDebut = dateFormatter.date(from: activity.dateDeDebut),
                                   let dateFin = dateFormatter.date(from: activity.dateDeFin)
                                {
                                    let frenchDateDebut = formatDateInFrench(dateDebut)
                                    let frenchDateFin = formatDateInFrench(dateFin)
                                    Text("Du \(frenchDateDebut) au \(frenchDateFin)")
                                        .font(.subheadline)
                                        .multilineTextAlignment(.leading)
//                                        .fixedSize(horizontal: false, vertical: true)

                                        
                                } else {
                                    Text("Date invalide")
                                }
                            }
                    }
                    Spacer()
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                            .foregroundColor(.grayDark)
                        
                        Text("12.4 km")
                            .font(.subheadline.weight(.light))
                            .foregroundColor(Color("GrayDark"))
                        .fontWeight(.light) }
                    Spacer()
                        .padding(.trailing, 4)
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
//                        if(activity.temporaire == "true"){
//                            Image(systemName: "calendar")
//                                .foregroundColor(.grayDark)
//                        }
                        Spacer()
//                        VoteCountDisplay2(activity: $activity)
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
            .padding(8)
        }.padding(2)
    }
}

#Preview {
    ListCard(activity: Activity.nature1).environmentObject(APIUserRequestModel())
}
