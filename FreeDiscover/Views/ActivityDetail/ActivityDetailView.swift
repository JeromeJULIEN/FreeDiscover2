//
//  ActivityDetailView.swift
//  FreeDiscover
//
//  Created by jerome julien on 19/10/2023.
//

import SwiftUI
import PhotosUI

struct ActivityDetailView: View {
    // activity to display
    @State var activity : FreeDiscover
    
    // bool to manage heart icon color (temp : will be define with the airtable DB)
    @State private var isFavorite : Bool = false
    private let url = URL(string: "https://www.freediscover.fr")!
    
    @StateObject var viewModel = UserModel()
    @State var selectedImage: UIImage?
    @State var isPickerShowing = false
    @State var buttonColor = Color.lightBlue
    
    @EnvironmentObject var activityGlobalVariables : ActivityGlobalVariables


    var body: some View {
        ScrollView{
            //VStack de la vue entiere
            VStack{
                //ShareButton()
                //            VStack {
                //                ShareLink(item: url) {
                //                    Image(systemName: "square.and.arrow.up")
                //                }
                //            }
                //            .swipeActions(){
                //                Button(action: {
                //                    let url = URL(string: "https://www.freediscover.fr")
                //                    let av = UIActivityViewController(activityItems: [url!], applicationActivities: nil)
                //
                //                    UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
                //                }) {
                //                    Label("", systemImage: "square.and.arrow.up")
                //                }
                
                //      .padding(5)
                
                //partie 1 fiche de l'activité
                
                // VStack de  photo + titre + créé par + laurier
                VStack () {
                    
                    ZStack (alignment: .topTrailing){
                        //  Image("calanque-en-vau")
                        Image(activity.image[0])
                            .resizable()
                            .scaledToFill()
                            .frame(maxHeight: 250)
                            .clipped()
                            .cornerRadius(10)
                        //.padding(5)
                        Button(action : {isFavorite = !isFavorite}){
                            ZStack {
                                Image(systemName: "heart.fill")
                                //        .padding(10)
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
                                //                                                            if(activity.temporary){
                                //                                                                Image(systemName: "calendar")
                                //                                                                    .foregroundColor(.grayDark)
                                //                                                            }
                                Text("\(activity.name)")
                                    .font(.title2.bold())
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            Spacer()
                            
                            HStack{
                                laurelleadingLevel()
                                Text ("Créé par Marion")
                                //     Text("\(activity.contributor)")
                                    .font(.subheadline)
                                    .foregroundColor(Color("GrayDark"))
                                    .frame(maxWidth: .infinity, alignment: .leading)                     .padding(5)
                                //Integrer la date //calendar.badge.clock
                            }
                            HStack{
                                if(activity.family){
                                    Image(systemName: "figure.2.and.child.holdinghands")
                                        .foregroundColor(.grayDark)
                                }
                                if(activity.accessibiliy){
                                    Image(systemName: "figure.roll")
                                        .foregroundColor(.grayDark)
                                        .frame(maxWidth: .infinity, alignment: .leading)                                //.padding(5)
                                    
                                }
                            }
                            if (activity.temporary == true){
                                Text("La date est : ")
                                //                                Text ("\(activity.startingDate)")
                                    .font(.subheadline)
                                    .frame(maxWidth: .infinity, alignment: .leading)                             //   .padding(5)
                            }
                        }

                    }
                    Divider()
                    
                    Text ("En quelques mots...")
                        .font(.title3.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)                                //.padding(5)
                    //Afficher s'il y a une date si c'est social sinon ne pas afficher
                    
                    Spacer()
                    
                    Text("\(activity.description)")
                    //                    .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                    VoteCountDisplay2(activity: $activity)
                    //                    .frame(height: 110)
                    //            Text ("Accessible toute l'année")
                    //                .font(.title3)
                        .frame(maxWidth: .infinity, alignment: .leading)                                .padding(5)
                    //            //picto accessibilité et famille
                    Divider ()
                    
                    
                    //Partie 2 : photos/vidéos
                    HStack{
                        //                    Text("Photos - vidéos")
                        //                        .font(.title3.bold())
                        //                    //                    .padding(5)
                        //                        .frame(maxWidth: .infinity, alignment: .leading)
                        Button(action: {
                            isPickerShowing = true
                        }) {
                        label: do {
                            Label ("Photos / Videos", systemImage: "photo.badge.plus" )
                        }
                            //                        CtaButton(ctaIcon: "photo.badge.plus", ctaBgColor: buttonColor, ctaFgColor: .grayDark)
                            ////                            .frame(minWidth: 40)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }
                    .sheet(isPresented: $isPickerShowing, onDismiss: nil) {
                        
                        //Image picker
                        ImagePicker(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing)
                    }
                    
                    if selectedImage != nil {
                        
                        
                        Image(uiImage: selectedImage!)
                            .resizable()
                            .frame(width: 150, height: 150)
                            .cornerRadius(10)
                        
                    }
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing:55){
                            ForEach(getTemporaryActivities(activityList: activityGlobalVariables.activities),id: \.id){
                                activity in
                                
                                //       VStack(alignment:.leading){
                                Image("\(activity.image[0])")
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
                                    .frame(maxWidth: .infinity, alignment: .leading)                     //           .padding(5)
                            }
                        }
                    }
                    
                    

                }
            }
            .padding()
        }
    }
    
}

#Preview {
    ActivityDetailView(activity: FreeDiscover.nature1)
        .environmentObject(UserGlobalVariables())
        .environmentObject(ActivityGlobalVariables())
}

