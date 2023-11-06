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
    @State var activity : Activity
    
    // bool to manage heart icon color (temp : will be define with the airtable DB)
    @State private var isFavorite : Bool = false
    private let url = URL(string: "https://www.freediscover.fr")!
    
    @StateObject var viewModel = UserModel()
    //    @State var selectedImage: UIImage?
    @State var selectedImages: [UIImage]?
    @State var isPickerShowing = false
    @State var buttonColor = Color.lightBlue
    
    @State private var startDate = Date()
    @State private var endDate = Date()
    
    
    @EnvironmentObject var activityGlobalVariables : APIActivityRequestModel
    
    
    var body: some View {
        ScrollView{
            //VStack de la vue entiere
            VStack{
                
                ZStack (alignment: .topTrailing){
                    //  Image("calanque-en-vau")
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
                        .frame(maxHeight: 250)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
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
                            ActivitySymbolSmall(activityType: activity.typeActivite)
                            //                                                            if(activity.temporary){
                            //                                                                Image(systemName: "calendar")
                            //                                                                    .foregroundColor(.grayDark)
                            //                                                            }
                            Text("\(activity.name)")
                                .font(.title2.bold())
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            ActivityContentView()

                        }
                        Spacer()
                        
                        HStack{
                            
                            Text ("Créé par Marion")
                            //     Text("\(activity.contributor)")
                                .font(.subheadline)
                                .foregroundColor(Color("GrayDark"))
                                .frame(maxWidth: .infinity, alignment: .leading)                     /*.padding(5)*/
                            laurelleadingLevel()
//                            Image("Badge1")
                                .frame(maxWidth: .infinity, alignment: .leading)                                //.padding(5)
                                .padding(5)
                            //Integrer la date //calendar.badge.clock
                        }

                        //   .padding(5)
                        
                        //                        DATE ACTIVIT2 :
                        if(activity.temporaire == "true"){
                            VStack {
                                if activity.dateDeDebut == activity.dateDeFin {
                                    
                                    if let date = dateFormatter.date(from: activity.dateDeDebut) {
                                        let frenchDate = formatDateInFrench(date)
                                        Text("Date : \(frenchDate)")
                                            .frame(maxWidth: .infinity, alignment: .leading)                                //.padding(5)

                                        
                                    } else {
                                        Text("Date invalide")
                                            .frame(maxWidth: .infinity, alignment: .leading)                                //.padding(5)

                                    }
                                }
                                else {
                                    if let dateDebut = dateFormatter.date(from: activity.dateDeDebut),
                                       let dateFin = dateFormatter.date(from: activity.dateDeFin)
                                    {
                                        let frenchDateDebut = formatDateInFrench(dateDebut)
                                        let frenchDateFin = formatDateInFrench(dateFin)
                                        Text("Date : du \(frenchDateDebut)\nau \(frenchDateFin)")
                                            .frame(maxWidth: .infinity, alignment: .leading)                                //.padding(5)

                                        
                                    } else {
                                        Text("Date invalide")
                                            .frame(maxWidth: .infinity, alignment: .leading)                                //.padding(5)

                                    }
                                    
                                    //  Text("Date : Du \(activity.dateDeDebut) au \(activity.dateDeFin)")
                                }
                            }
//                            .padding(0)
                            .shadow(radius: 1)
                            .opacity(0.8)
                            .frame(maxWidth: .infinity, alignment: .leading)                                //.padding(5)
                    .clipShape(RoundedRectangle(cornerRadius:10))
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
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)                                /*.padding(5)*/
                //            //picto accessibilité et famille
                
                HStack{
                    if(activity.famille == "true"){
                        Image(systemName: "figure.2.and.child.holdinghands")
                            .foregroundColor(.grayDark)
                    }
                    if(activity.accessibilite == "true"){
                        Image(systemName: "figure.roll")
                            .foregroundColor(.grayDark)
                            .frame(maxWidth: .infinity, alignment: .leading)                                //.padding(5)
                        
                    }
                }
                Divider ()
                
                
                //Partie 2 : photos/vidéos
                HStack{
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
                    
                    
                    //Image picker pour une seule
                    //                        ImagePicker(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing)
                    //                    }
                    
                    //Image picker pour selectionner plusieurs photos en 1 fois
                    
                    ImagePickerView(numOfSelectedPictures: 5, images: $selectedImages)
                    
                }
                ScrollView(.horizontal) {
                    //                        VStack(alignment:.leading){
                    
                    HStack (){
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
                            .frame(width: 150,height: 150)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                        //    Text("\(activity.name)")
                        //      .foregroundColor(.grayDark)
                        //    .font(.headline)
                        //  .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                        // .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                        // }
                        if selectedImages != nil {
                            //
                            //                            HStack(spacing: 10) {
                            ForEach(Array(selectedImages?.indices ?? 0..<0), id: \.self) { index in
                                if let image = selectedImages?[index] {
                                    Image(uiImage: image)
                                        .resizable()
                                        .overlay(
                                            Button(action: {
                                                selectedImages?.remove(at: index)
                                            }) {
                                                Image(systemName: "x.circle.fill")
                                                    .foregroundColor(.white)
                                            }
//                                                .padding(0)
                                                .shadow(radius: 1)
                                                .opacity(0.8)
                                            , alignment: .topTrailing)
                                        .frame(width: 150, height: 150)
                                        .clipShape(RoundedRectangle(cornerRadius:10))
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .padding()
    }
}
#Preview {
    ActivityDetailView(activity: Activity.nature1).environmentObject(APIUserRequestModel())
}



