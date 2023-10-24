//
//  ActivityDetailView.swift
//  FreeDiscover
//
//  Created by jerome julien on 19/10/2023.
//

import SwiftUI

struct ActivityDetailView: View {
    var body: some View {
        VStack (spacing: 30){
            //partie 1 fiche de l'activité
            VStack (alignment: .leading) {
                Image("calanque-en-vau")
                    .resizable()
                    .scaledToFill()
                    .frame(maxHeight: 250)
                    .clipped()
                    .overlay (alignment: .topTrailing) {
                        HStack {
                            Spacer()
                            // Button(action: {                        // Bouton //coeur favoris
                            //   nature1.favorite.toggle()
                            //}) {
                            //  Image(systemName: nature1.favorite ? "heart.fill" : "heart")
                            //    .foregroundColor(nature1.favorite ? .blue : .white)
                            //} .bold()
                            //  .font(.title)
                            //.padding()
                        }
                    }
                VStack{
                    HStack{
                        Text("Calanque d'en Vau")
                            .font(.title3.bold())
                            .padding(5)
                        Spacer()
                        VoteCountDisplay(voteCount: 10)
                        Text("12,4 km")
                            .font(.subheadline.weight(.light))
                            .foregroundColor(Color("GrayDark"))
                            .padding(5)
                        
                    }
                    // créer les pouces + et -
                    
                    Text ("Créé par Marion")
                        .font(.subheadline)
                        .foregroundColor(Color("GrayDark"))
                        .frame(maxWidth: .infinity, alignment: .leading)                                .padding(5)
                    
                  //  Divider()
                    
                    Text ("En quelques mots...")
                        .font(.title3)
                        .frame(maxWidth: .infinity, alignment: .leading)                                .padding(5)
                    Text("Située entre Marseille et Cassis, c’est la calanque la plus grandiose du parc national avec ses eaux turquoise.")
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)                                .padding(5)
                    Text ("Date : Période de forte affluence mai à octobre")
                        .font(.title3)
                        .frame(maxWidth: .infinity, alignment: .leading)                                .padding(5)
                    //picto accessibilité et famille
                }
                
                
                
            }
            .background(.white)
            
            .cornerRadius(10)
            .padding(15)
            
            .shadow(color: Color.gray .opacity(0.8), radius: 14, x: 5, y:5)
            
            //Partie 2 : photos/vidéos
            Text("Photos/vidéos")
                .font(.title3.bold())                    .foregroundColor(Color("GrayDark"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(15)
            
            HStack(spacing:55){
                
                VStack{
                    Image("calanque-en-vau")
                        .resizable()
                        .cornerRadius(18)
                        .frame(width: 100, height: 100)
                    //Text("22/10/23")
                }
                
                VStack{
                    Image("calanque-grotte-bleu")
                        .resizable()
                        .cornerRadius(18)
                        .frame(width: 100, height: 100)
                    //Text("13/07/2023")
                }
                
                VStack{
                    Image("calanque-morgiou")
                        .resizable()
                        .cornerRadius(18)
                        .frame(width: 100, height: 100)
                    //Text("04/05/2023")
                }
            }

        }
    
        
        }
    }


#Preview {
    ActivityDetailView()
}

