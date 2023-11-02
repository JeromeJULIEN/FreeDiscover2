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
    
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State var activityName: String = ""
    @State var activityDescription: String = ""
    @State var currentCategory: ActivityTypes
    @State var isTemporary: Bool
    @State var isPickerShowing = false
    @State var isLocationPickerShowing = false
    @State var selectedImages: [UIImage]?
    
//    var dateFormatter: DateFormatter {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .long
//        return formatter
//    }
    
    @State var buttonColor = Color.lightBlue

    
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
        }
            HStack {
                Button(action: {
                    print("")
                }) {
                    AccessibilitySymbol(accessSymbol: "figure.2.and.child.holdinghands", accessName: "Familiale")
                }
                Button(action: {
                    print("")
                }) {
                    AccessibilitySymbol(accessSymbol: "figure.roll", accessName: "Accessible")
                }
                
            
                
            }
            Spacer()
            CtaButton(ctaText: "Créer mon activité", ctaIcon: "", ctaBgColor: .grayLight, ctaFgColor: .accentColor)
                .padding()
        }
    }


#Preview {
    CreateActivityView(currentCategory: .nature, isTemporary: false)
}
