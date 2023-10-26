//
//  ActivityDetailView.swift
//  FreeDiscover
//
//  Created by jerome julien on 19/10/2023.
//

import SwiftUI

struct ActivityDetailView: View {
    var body: some View {
        //VStack de la vue entiere
        VStack {
            
            
            VStack (spacing: 30){
                
                
                //partie 1 fiche de l'activité
                
                // VStack de  photo + titre + créé par + laurier
                VStack (alignment: .leading) {
                    Image("calanque-en-vau")
                        .resizable()
                        .scaledToFill()
                        .frame(maxHeight: 250)
                        .clipped()
                    // .overlay (alignment: .topTrailing)
                    //{
                    
                    //            Spacer()
                    // Button(action: {                        // Bouton //coeur favoris
                    //   nature1.favorite.toggle()
                    //}) {
                    //  Image(systemName: nature1.favorite ? "heart.fill" : "heart")
                    //    .foregroundColor(nature1.favorite ? .blue : .white)
                    //} .bold()
                    //  .font(.title)
                    //.padding()
                    
                    // }
                    //HStack{
                    VStack (spacing : 0) {
                        Text("Calanque d'en Vau")
                            .font(.title3.bold())
                            .padding(5)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        //     Text("12,4 km")
                        //       .font(.subheadline.weight(.light))
                        //     .foregroundColor(Color("GrayDark"))
                        //     .frame(maxWidth: .infinity, alignment: .leading)
                        //   .padding(5)
                        //     HStack{
                        //       Text ("Créé par Marion")
                        //         .font(.subheadline)
                        //       .foregroundColor(Color("GrayDark"))
                        //     .frame(maxWidth: .infinity, alignment: .leading)                     .padding(5)
                        // LaurelLeadingLevel()
                        //     .frame(width: 50, height: 50)
                        //       .padding(5)
                    }
                    
                    
                    
                }
                
            }
            .background(.white)
            .cornerRadius(10)
            .padding(15)
            .shadow(color: Color.gray .opacity(0.8), radius: 14, x: 5, y:5)
            
            
            
            
            HStack (spacing: 30){
                HStack (spacing: 30){
                    Spacer()
                    //       ThumbsupButton()
                    //     ThumbsdownButton()
                    //       .frame(maxWidth: .infinity, alignment: .leading)
                    //.padding(5)
                    //
                    
                }
                
                VoteCountDisplay(voteCount: 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            //    HStack{
            
            
            //  }
            
            
            //  Divider()
            
            //   Text ("En quelques mots...")
            //     .font(.title3)
            //   .frame(maxWidth: .infinity, alignment: .leading)                                .padding(5)
            // Text("Située entre Marseille et Cassis, c’est la calanque la plus grandiose du parc national avec ses eaux turquoise.")
            // .font(.subheadline)
            // .frame(maxWidth: .infinity, alignment: .leading)                                .padding(5)
            Text ("Accesible toute l'année")
                .font(.title3)
                .frame(maxWidth: .infinity, alignment: .leading)                                .padding(5)
            //picto accessibilité et famille
            Divider ()
            //Partie 2 : photos/vidéos
            Text("Photos/vidéos")
                .font(.title3.bold())
                .padding(5)
                .frame(maxWidth: .infinity, alignment: .leading)
            //        ScrollView(.horizontal, showsIndicators: false){
            //            HStack(spacing:40){
            //                ForEach(getTemporaryActivities(),id: \.id){
            //                    activity in
            //                    NavigationLink(destination:ActivityDetailView()){
            //                 //       VStack(alignment:.leading){
            //                            Image("\(activity.image)")
            //                               .resizable()
            //                               .aspectRatio(contentMode: .fill)
            //                               .frame(width: 110, height: 110)
            //                               .clipShape(RoundedRectangle(cornerRadius: 8))
            //                        //    Text("\(activity.name)")
            //                          //      .foregroundColor(.grayDark)
            //                            //    .font(.headline)
            //                              //  .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
            //                               // .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            //                   //     }
            //                        .frame(width: 110)
            //
            //                    }
            //                }
            //            }
            //        }
            //Partie photo
            //       Text("Photos/vidéos")
            //         .font(.title3.bold())
            //       .foregroundColor(Color("GrayDark"))
            //     .frame(maxWidth: .infinity, alignment: .leading)                                .padding(5)
            
            //     HStack(spacing:55){
            
            //       VStack{
            //         Image("calanque-en-vau")
            //           .resizable()
            //         .cornerRadius(18)
            //       .frame(width: 150, height: 150)
            //     .frame(maxWidth: .infinity, alignment: .leading)                                .padding(5)
            //Text("22/10/23")
            //      }
            
            //    VStack{
            //      Image("calanque-grotte-bleu")
            //        .resizable()
            //      .cornerRadius(18)
            //    .frame(width: 150, height: 150)
            //Text("13/07/2023")
            //   }
            
            // VStack{
            //   Image("calanque-morgiou")
            //     .resizable()
            //   .cornerRadius(18)
            // .frame(width: 150, height: 150)
            //Text("04/05/2023")
            //    }
            
            // }
            //    .frame(maxWidth: .infinity, alignment: .leading)                                .padding(5)
            //  Spacer()
            
        }
        
    }
}
    

#Preview {
    ActivityDetailView()
}

