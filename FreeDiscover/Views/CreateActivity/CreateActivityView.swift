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
    
    func dateToString(_ date: Date) -> String {
        let formatter = DateFormatter()
        // Définissez le format de date que vous souhaitez
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter.string(from: date)
    }
    
    func findHighestID(activities: [Activity]) -> Int {
        guard let maxId = activities.max(by: { $0.id < $1.id })?.id else {return 0}
        return maxId
    }
    
    
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
                    isFamilyFriendly = true
                }) {
                    AccessibilitySymbol(accessSymbol: "figure.2.and.child.holdinghands", accessName: "Familiale")
                }
                .padding(10)
                Button(action: {
                    isAccessible = true
                }) {
                    AccessibilitySymbol(accessSymbol: "figure.roll", accessName: "Accessible")
                }
                .padding(10)
                   
            }
            Spacer()
            Button(action: {
                let newActivity = Activity(dateDeFin: dateToString(endDate), id: findHighestID(activities: activityGlobalVariables.allActivities)+1, photos: selectedImages ?? Image(systemName:  "questionmark.video"), favoriteByUserID: <#T##[String]#>, famille: String(isFamilyFriendly), vote: 0, accessibilite: String(isAccessible), latitude: NewLocation.latitude, upVote: [String], longitude: NewLocation.longitude, description: activityDescription, typeActivite: currentCategory.rawValue, temporaire: String(isTemporary), name: activityName, dateDeDebut: String(startDate), creator: currentUser, idFromCreator: currentUser.id, idFromFavoriteByUserID: <#T##[Int]#>, idFromUpVote: <#T##[Int]#>, downVote: <#T##[String]#>, idFromDownVote: <#T##[Int]#>)
                showingAlertCreated = true
            }) {
                CtaButton(ctaText: "Créer mon activité", ctaIcon: "", ctaBgColor: .socialRed, ctaFgColor: .grayLight)
                    .padding()
            }
        }
        .alert(isPresented: $showingAlertCreated) {
                    Alert(title: Text("Votre activité a été créée"), message: Text(""), dismissButton: .default(Text("OK")))
                }
        .navigationTitle("Créer une activité")
    }
}


#Preview {
    CreateActivityView(currentCategory: .nature, isTemporary: false, currentUser: User.marion)
}
