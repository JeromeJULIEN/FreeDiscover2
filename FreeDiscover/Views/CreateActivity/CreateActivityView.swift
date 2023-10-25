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
    //  @State private var currentCategory: CategoryMode = .nature
    //  @State private var currentActivityType = "Nature"
    // let activityTypes =  ["Nature", "Culture", "Sport", "Social"]
    @State private var dates: Set<DateComponents> = []
    @State private var showingSheet = false
    @State var activityName: String = ""
    @State var activityDescription: String = ""
    @State var symbolSelection: Int = 1
    @State var activityCategory: activityTypes
    @State var isTemporary: Bool
    //
    @StateObject var viewModel = UserModel()
    
    
    var body : some View {
        
        ScrollView {
            VStack {
                CategoryPicker(activityCategory: .nature)
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
                
                Toggle("Il s'agit d'une activité temporaire", isOn: $isTemporary)
                    .foregroundColor(Color.grayDark)
                    .padding()
                    .background(Color.grayLight)
                    .cornerRadius(5.0)
                    .padding()
                
                if isTemporary == true {
                    Button(action: {
                        showingSheet = true
                    }) {
                        CtaButton(ctaText: "Sélectionner une date", ctaIcon: "calendar", ctaBgColor: .grayLight, ctaFgColor: .accentColor)
                            .padding()
                    }
                } else {
                    Text("")
                        .frame(width:280, height:52)
                        .padding()
                    
                }
            }
            
            
            
            
            //       Button(action: {
            //           print("pouet")
            //       }) {
            //            CtaButton(ctaText: "Ajouter une photo/vidéo", ctaIcon: "photo.badge.plus", ctaBgColor: .lightBlue, ctaFgColor: .grayDark)
            //           
            //       }
            //       .frame(minWidth: 340)
            
            EditableDisplayedImage(viewModel: viewModel)
            
            Button(action: {
                print("pouet")
            }) {
                CtaButton(ctaText: "Sélectionner l'emplacement", ctaIcon: "location", ctaBgColor: .lightBlue, ctaFgColor: .grayDark)
                    .frame(minWidth: 340)
            }
            
            
            .sheet(isPresented: $showingSheet) {
                MultiDatePicker("Sélectionner une date", selection: $dates)
            }
            
            Button(action: {
                print("pouet")
            }) {
                CtaButton(ctaText: "Ajouter une photo/vidéo", ctaIcon: "photo.badge.plus", ctaBgColor: .lightBlue, ctaFgColor: .grayDark)
                    .frame(minWidth: 340)
            }
            HStack {
                Button(action: {
                    self.symbolSelection = 1
                }) {
                    AccessibilitySymbol(symbolSelection: 2, accessSymbol: "figure.2.and.child.holdinghands", accessName: "Familiale")
                }
                Button(action: {
                    self.symbolSelection = 0
                }) {
                    AccessibilitySymbol(symbolSelection: 2, accessSymbol: "figure.roll", accessName: "Accessible")
                }
                
            }
            Spacer()
            CtaButton(ctaText: "Créer mon activité", ctaIcon: "", ctaBgColor: .grayLight, ctaFgColor: .accentColor)
                .padding()
        }
    }
}

#Preview {
    CreateActivityView(activityCategory: .nature, isTemporary: false)
}
