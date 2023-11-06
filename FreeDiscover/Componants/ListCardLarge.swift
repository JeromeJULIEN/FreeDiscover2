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
                .frame(height: 240)
                .foregroundColor(.white)
                .shadow(radius: 2)
            HStack(alignment: .top) {
                    VStack(alignment: .leading){
                        Text("\(activity.name)")
                            .font(.title3.bold())
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                        Spacer()
                        
                        if(activity.temporaire == "true"){
                                if activity.dateDeDebut == activity.dateDeFin {
                                    
                                if let date = dateFormatter.date(from: activity.dateDeDebut) {
                                    let frenchDate = formatDateInFrench(date)
                                    Text("\(frenchDate)")
                                        .font(.subheadline)
                                        .multilineTextAlignment(.leading)
                                        
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
                                        Text("Du \(frenchDateDebut) \nau \(frenchDateFin)")
                                            .font(.subheadline)
                                            .multilineTextAlignment(.leading)
                                            
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
                                .foregroundColor(Color.grayDark)
                            .padding([.top, .bottom], 8) }
                        
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

                        } .padding(.bottom, 4)
                        // VoteCountDisplay2(activity: $activity)
                          //  .padding([.bottom], 0)
                    }
                    .frame(height: 170)
                                    Spacer()
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
                           .frame(width: 170, height: 170)
                           .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                        FavoriteButton(activityId: activity.id)
                    }
            }
            .padding(16)
        } .padding(2)
    }
}

#Preview {
    ListCardLarge(activity: Activity.nature1).environmentObject(APIUserRequestModel())
}

