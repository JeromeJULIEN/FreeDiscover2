//
//  ListCardLarge.swift
//  FreeDiscover
//
//  Created by apprenant92 on 02/11/2023.
//

import SwiftUI

struct ListCardLarge: View {
    @State var activity : Activity
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 12)
                .ignoresSafeArea()
                .frame(height: 220)
                .foregroundColor(.white)
                .shadow(radius: 2)
            VStack(spacing: 0) {
                
                  //  .padding()
                HStack{
                    
                    VStack(spacing: 0){
                        Text("\(activity.name)")
                            .font(.title3.bold())
                        Spacer()
                        // .padding()
                        
//                        Text("\(activity.description)")
//                            .font(.caption)
//                            .fontWeight(.light)
//                            .lineLimit(4)
//                            .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
//                            .fixedSize(horizontal: false, vertical: true)
//                            .padding(.leading)
                        if(activity.temporaire == "true"){
                            VStack {
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
                                        Text("Date : du \(frenchDateDebut) au \(frenchDateFin)")
                                            
                                    } else {
                                        Text("Date invalide")
                                    }
                                    
                                  //  Text("Date : Du \(activity.dateDeDebut) au \(activity.dateDeFin)")
                                }
                            }
                        }
                        
                        Text("12.4 km")
                            .font(.subheadline.weight(.light))
                            .foregroundColor(Color.grayDark)
                            .padding([.top], 5)

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
                                
                          
                            
                        } .padding([.bottom], 5)
                        // VoteCountDisplay2(activity: $activity)
                          //  .padding([.bottom], 0)
                    }
                    .frame(height: 180)
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
                                        .progressViewStyle(.circular)
                                }
                            }
                           .frame(width: 150, height: 150)
                           .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                        FavoriteButton(activityId: activity.id)
                        
                        
                    }
                    .padding([.trailing], 10)
                }
            }
            .padding(10)
        }
    }
}

#Preview {
    ListCardLarge(activity: Activity.nature1).environmentObject(APIUserRequestModel())
}

