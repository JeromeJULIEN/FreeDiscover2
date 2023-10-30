//
//  ActivityDetailView.swift
//  FreeDiscover
//
//  Created by jerome julien on 19/10/2023.
//

import SwiftUI

struct ActivityDetailView: View {
    // activity to display
    var activity : FreeDiscover
    
    // bool to manage heart icon color (temp : will be define with the airtable DB)
    @State private var isFavorite : Bool = false
    
    var body: some View {
        
        //VStack de la vue entiere
        VStack{
            ShareButton()
                .padding(5)
            
            //partie 1 fiche de l'activité
            
            // VStack de  photo + titre + créé par + laurier
            VStack (alignment: .leading) {
                
                ZStack (alignment: .topTrailing){
                    //  Image("calanque-en-vau")
                    Image(activity.image)
                        .resizable()
                        .scaledToFill()
                        .frame(maxHeight: 250)
                        .clipped()
                        .cornerRadius(10)
                        .padding(5)
                    Button(action : {isFavorite = !isFavorite}){
                        ZStack {
                            Image(systemName: "heart.fill")
                                .padding(10)
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
                
                VStack {
                        VStack{
                        HStack (){
                            ActivitySymbolSmall(activityType: activity.type)
                            //                                if(activity.family){
                            //                                    Image(systemName: "figure.2.and.child.holdinghands")
                            //                                        .foregroundColor(.grayDark)
                            //                                }
                            //                                if(activity.accessibiliy){
                            //                                    Image(systemName: "figure.roll")
                            //                                        .foregroundColor(.grayDark)
                            //                                }
                            //                                if(activity.temporary){
                            //                                    Image(systemName: "calendar")
                            //                                        .foregroundColor(.grayDark)
                            //                                }
                            Text("\(activity.name)")
                            //                            Text("Calanque d'en Vau")
                                .font(.title2.bold())
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()
                            
                            VoteCountDisplay(voteCount: activity.voteCounter)
                            //                                .padding(15)                            }
                            Spacer()
                            
                            
                            //                                .padding(.trailing, 100)
                            
                        }
                        //     Text("12,4 km")
                        //       .font(.subheadline.weight(.light))
                        //     .foregroundColor(Color("GrayDark"))
                        //     .frame(maxWidth: .infinity, alignment: .leading)
                        //   .padding(5)
                            HStack{
                                laurelleadingLevel()
                                    .frame(width: 50, height: 50)
                                    .padding(5)
                                Text ("Créé par Marion")
                                    .font(.subheadline)
                                    .foregroundColor(Color("GrayDark"))
                                    .frame(maxWidth: .infinity, alignment: .leading)                     .padding(5)
                            }
                        }
                }
                Divider()
                
                Text ("En quelques mots...")
                    .font(.title3)
                    .frame(maxWidth: .infinity, alignment: .leading)                                .padding(5)
                //Afficher s'il y a une date si c'est social sinon ne pas afficher
                if (activity.temporary == true){
                    Text ("Date: Toute l'année")
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)                                .padding(5)
                }
                Text("Située entre Marseille et Cassis, c’est la calanque la plus grandiose du parc national avec ses eaux turquoise.")
                    .font(.subheadline)
                    .frame(width: 400, height: 50)
                //            Text ("Accessible toute l'année")
                //                .font(.title3)
                //                .frame(maxWidth: .infinity, alignment: .leading)                                .padding(5)
                //            //picto accessibilité et famille
                Divider ()
                
                
                //Partie 2 : photos/vidéos
                Text("Photos/vidéos")
                    .font(.title3.bold())
                    .padding(5)
                    .frame(maxWidth: .infinity, alignment: .leading)
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing:55){
                        ForEach(getTemporaryActivities(),id: \.id){
                            activity in
                            
                            //       VStack(alignment:.leading){
                            Image("\(activity.image)")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 150, height: 150)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            //    Text("\(activity.name)")
                            //      .foregroundColor(.grayDark)
                            //    .font(.headline)
                            //  .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                            // .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                            //     }
                                .frame(maxWidth: .infinity, alignment: .leading)                                .padding(5)
                        }
                    }
                }
                
                
            }
        }
//        .padding()
    }
    
}

#Preview {
    ActivityDetailView(activity: FreeDiscover.nature1)
}

