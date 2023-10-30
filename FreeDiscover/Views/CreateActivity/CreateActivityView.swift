//
//  CreateActivity.swift
//  FreeDiscover
//
//  Created by jerome julien on 19/10/2023.
//

import SwiftUI
import PhotosUI
import HorizonCalendar

enum DurationMode {
    case temporary, permanent
}


struct CreateActivityView: View {
    
    @State private var dates: Set<DateComponents> = []
    @State private var date = Date()
    @State private var showingCalendar = false
    @State var activityName: String = ""
    @State var activityDescription: String = ""
    @State var symbolSelection: Int = 1
    @State var currentCategory: ActivityTypes
    @State var activityCategory: ActivityTypes
    @State var isTemporary: Bool
    @State var isPickerShowing = false
    //
    @StateObject var viewModel = UserModel()
    @State var selectedImage: UIImage?

    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    @State var activityDate = Date()
    @State var pickedCategory: activityCategory
    @State var buttonColor = Color.lightBlue
    @State var shouldChangeColor = false
    
    var body : some View {
        
        ScrollView {
            VStack {
                CategoryPicker(currentCategory: currentCategory, pickedCategory: pickedCategory)
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
                    print("pouet")
                }) {
                    CtaButton(ctaText: "Sélectionner l'emplacement", ctaIcon: "location", ctaBgColor: buttonColor, ctaFgColor: .grayDark)
                        .frame(minWidth: 340)
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
                            "Date :",
                            selection: $date, in: Date.now...,
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
                ImagePicker(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing)
            }
            
            if selectedImage != nil {
               
                    
                    Image(uiImage: selectedImage!)
                        .resizable()
                        .frame(width: 150, height: 150)
                        .cornerRadius(10)
                    
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
}

#Preview {
    CreateActivityView(currentCategory: .nature, isTemporary: false, pickedCategory: culture)
}
