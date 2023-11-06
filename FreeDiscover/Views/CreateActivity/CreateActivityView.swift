//
//  CreateActivity.swift
//  FreeDiscover
//
//  Created by jerome julien on 19/10/2023.
//

import SwiftUI
import PhotosUI

enum DurationMode {
    case temporary, permanent
}


struct CreateActivityView: View {
    
    @EnvironmentObject var activityGlobalVariables : APIActivityRequestModel
    
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State var activityName: String = ""
    @State var activityDescription: String = ""
    @State var currentCategory: ActivityTypes
    @State var isTemporary: Bool
    @State var isPickerShowing = false
    @State var isLocationPickerShowing = false
    @State var selectedImages: [UIImage]?
    //  @State var activity : Activity
    @State var isFamilyFriendly = false
    @State var isAccessible = false
    @State var currentUser: User
    //@State var showingAlertLocation = false
    @State private var showingAlertCreated = false
    @State var buttonColor = Color.lightBlue

    @EnvironmentObject var userGlobalVariables : APIUserRequestModel
    
    let newLocation: NewLocation

    
    var body : some View {
        
        ScrollView {
            VStack {
                CategoryPicker(currentCategory: currentCategory)
                    .padding()
                
                TextField(("Nom de l'activité..."),
                          text: $activityName)
                .padding()
                .background(Color.grayLight)
                .cornerRadius(5.0)
                .padding()
                
                TextField(("Description de l'activité..."),
                          text: $activityDescription,
                          axis: .vertical)
                .lineLimit(2...4)
                .padding()
                .background(Color.grayLight)
                
                .cornerRadius(5.0)
                .padding()
                //    .textFieldStyle(.roundedBorder)
                
                
                Button(action: {
                    isLocationPickerShowing = true
                }) {
                    CtaButton(ctaText: "Sélectionner l'emplacement", ctaIcon: "location", ctaBgColor: buttonColor, ctaFgColor: .grayDark)
                        .frame(minWidth: 340)
                }
                .sheet(isPresented: $isLocationPickerShowing, onDismiss: nil) {
                    LocationPickerView()
                }
                Toggle("Il s'agit d'une activité temporaire", isOn: $isTemporary)
                    .toggleStyle(.switch)
                    .tint(.accentColor)
                    .foregroundColor(Color.grayDark)
                    .padding()
                    .background(Color.grayLight)
                    .cornerRadius(5.0)
                    .padding()
                
                if isTemporary == true {
                    
                    DatePicker(
                        "Date de début :",
                        selection: $startDate, in: Date.now...,
                        displayedComponents: [.date]
                    )
                    .padding(.horizontal, 60)
                    
                    DatePicker(
                        "Date de fin :",
                        selection: $endDate, in: startDate...,
                        displayedComponents: [.date]
                    )
                    .padding(.horizontal, 60)
                    
                } else {
                    // Text("")
                    //   .frame(width:280, height:52)
                    //    .padding()
                    
                }
            }
            
            
            Button(action: {
                isPickerShowing = true
            }) {
                CtaButton(ctaText: "Ajouter une photo/vidéo", ctaIcon: "photo.badge.plus", ctaBgColor: buttonColor, ctaFgColor: .grayDark)
                    .frame(minWidth: 340)
            }
            .sheet(isPresented: $isPickerShowing, onDismiss: nil) {
                
                //Image picker
                ImagePickerView(numOfSelectedPictures: 5, images: $selectedImages)
                let imageModels = selectedImages?.map { image in
                        ImageDataModel(id: UUID().uuidString, width: 1000, height: 1000, url: "", filename: "image\(UUID().uuidString)", size: 2800, type: "image.jpeg", thumbnails: Thumbnails(small: .init(url: "", width: 0, height: 0), large: .init(url: "", width: 0, height: 0), full: .init(url: "", width: 1000, height: 1000)))
                    } ?? []
            }
            
            if selectedImages != nil {
                
                ScrollView(.horizontal) {
                    HStack(spacing: 10) {
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
                                            .padding(0)
                                            .shadow(radius: 1)
                                            .opacity(0.8)
                                        , alignment: .topTrailing)
                                    .frame(width: 150, height: 150)
                                    .clipShape(RoundedRectangle(cornerRadius:10))
                            }
                        }
                    }
                    .padding()
                }
            }
            
            HStack {
                Button(action: {
                    isFamilyFriendly.toggle()
                }) {
                    AccessibilitySymbol(isOn : $isFamilyFriendly, accessSymbol: "figure.2.and.child.holdinghands", accessName: "Familiale" )
                }
                .padding(10)
                Button(action: {
                    isAccessible.toggle()
                }) {
                    AccessibilitySymbol(isOn : $isAccessible,accessSymbol: "figure.roll", accessName: "Accessible" )
                }
                .padding(10)
                   
            }
            Spacer()
            Button(action: {
                
                Task {
                    let newActivity = Activity(dateDeFin: dateToString(endDate),
                                               id: findHighestID(activities: activityGlobalVariables.allActivities)+1,
                                               photos: [ImageDataModel(id: "1", width: 1000, height: 1000, url: "", filename: "calanque-en-vau", size: 2800, type: "image.jpeg", thumbnails: Thumbnails(small: .init(url: "", width: 0, height: 0), large: .init(url: "", width: 0, height: 0), full: .init(url: "", width: 1000, height: 1000)))],
                                               favoriteByUserID: ["rec1v1YrspAhE25pi"],
                                               famille: String(isFamilyFriendly),
                                               vote: 0,
                                               accessibilite: String(isAccessible),
                                               latitude: newLocation.newLatitude,
                                               upVote: ["rec1v1YrspAhE25pi"],
                                               longitude: newLocation.newLongitude,
                                               description: activityDescription,
                                               typeActivite: currentCategory.rawValue,
                                               temporaire: String(isTemporary),
                                               name: activityName,
                                               dateDeDebut: dateToString(startDate),
                                               creator: ["rec1v1YrspAhE25pi"],
                                               idFromCreator: [1],
                                               idFromFavoriteByUserID: [1],
                                               idFromUpVote: [1],
                                               downVote: ["rec1v1YrspAhE25pi"],
                                               idFromDownVote: [2]
                                    )
                    print("newActivity from createActivity page : \(newActivity.name)")
                    await activityGlobalVariables.createActivity(activity: newActivity)

                    showingAlertCreated = true
                }
               
            }) {
                CtaButton(ctaText: "Créer mon activité", ctaIcon: "", ctaBgColor: .socialRed, ctaFgColor: .grayLight)
                    .padding()
            }
        }
        .alert(isPresented: $showingAlertCreated) {
                    Alert(title: Text("Votre activité a été créée"), message: Text(""), dismissButton: .default(Text("OK")))
                }
        .navigationTitle("Créer une activité")
        .onChange(of: activityGlobalVariables.needsRefresh) { newValue in
                    if newValue {
                        Task {
                            await activityGlobalVariables.refreshData()
                        }
                    }
                }
    }
}


#Preview {

    CreateActivityView(currentCategory: .nature, 
                       isTemporary: false,
                       currentUser: User.marion,
                       newLocation: NewLocation(id: UUID(), newLatitude: 0.0, newLongitude: 0.0))

}

//static let nature1 = Activity(dateDeFin: "31/12/2100", id: 1,
//                              photos: [ImageDataModel(id: "1", width: 1000, height: 1000, url: "", filename: "calanque-en-vau", size: 2800, type: "image.jpeg", thumbnails: Thumbnails(small: .init(url: "", width: 0, height: 0), large: .init(url: "", width: 0, height: 0), full: .init(url: "", width: 1000, height: 1000)))],
//                              favoriteByUserID: ["1"],
//                              famille: "false",
//                              vote: 5,
//                              accessibilite: "false",
//                              latitude: 43.20233894144298,
//                              upVote: ["1"],
//                              longitude: 5.498078687708157,
//                              description: "Située entre Marseille et Cassis, c’est la calanque la plus grandiose du parc national avec ses eaux turquoise.",
//                              typeActivite: "nature",
//                              temporaire: "false",
//                              name: "Calanque d'en vau",
//                              dateDeDebut: "01/01/2000",
//                              creator: ["2"],
//                              idFromCreator: [1],
//                              idFromFavoriteByUserID: [1],
//                              idFromUpVote: [1],
//                              downVote: ["2"],
//                              idFromDownVote: [2])
