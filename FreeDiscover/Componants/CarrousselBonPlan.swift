//
//  CarrousselBonPlan.swift
//  FreeDiscover
//
//  Created by jerome julien on 21/10/2023.
//

import SwiftUI

struct CarrousselBonPlan: View {
    @EnvironmentObject var activityGlobalVariables : APIActivityRequestModel

    
    var body: some View {
        NavigationView{
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .ignoresSafeArea()
                    .frame(height: 220)
                    .foregroundColor(.white)
                    .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                VStack(alignment : .leading){
                    HStack {
                        Spacer()
                        Text("Nos bons plans du moment")
                            .font(.headline)
                        .foregroundColor(.grayDark)
                        Spacer()
                    }
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing:40){
                            ForEach(getTemporaryActivities(activityList: activityGlobalVariables.allActivities),id: \.id){
                                activity in
                                NavigationLink(destination:ActivityDetailView(activity: activity)){
                                    VStack(alignment:.leading){
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
                                        Text("\(activity.name)")
                                            .foregroundColor(.grayDark)
                                            .font(.headline)
                                            .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                                            .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                                            .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                                    }
                                    .frame(width: 110)

                                }
                            }
                        }
                    }
                    
                }
                /// autoriser les interaction avec la carte malgré l'affichage de la sheet carroussel
                
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .padding(.leading,10)
                .padding(.top,20)
                /// limitation de la taille de la sheet
                
                /// bloquer la possibilité de fermer la sheet avec un swipe down
                /// .interactiveDismissDisabled()
                
            }
        }
        .presentationBackgroundInteraction(.enabled(upThrough: .height(200)))
        .presentationDetents([.height(200),.large])
        .presentationCornerRadius(20)
      // .presentationDragIndicator(.visible)
      //  .ignoresSafeArea(.all)
    }
        
}

#Preview {
    CarrousselBonPlan().environmentObject(APIActivityRequestModel())
}
