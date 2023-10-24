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
    @State var currentMode: DurationMode = .temporary
    //  @State private var currentCategory: CategoryMode = .nature
  //  @State private var currentActivityType = "Nature"
    // let activityTypes =  ["Nature", "Culture", "Sport", "Social"]
    @State private var dates: Set<DateComponents> = []
    @State private var showingSheet = false
    @State var activityName: String = ""
    @State var activityDescription: String = ""
    @State var symbolSelection: Int = 1
    @State var activityCategory: activityTypes
   // 
    @StateObject var viewModel = UserModel()
    
    
    var body : some View {
        VStack {
            CategoryPicker(activityCategory: .nature)
                .padding()
            
            TextField(("Nom de l'activité"), 
                      text: $activityName)
                .padding()
                .background(Color.grayLight)
                .cornerRadius(5.0)
                .padding()
            TextField(("Description de l'activité"),
                      text: $activityDescription,
                      axis: .vertical)
                .lineLimit(3...4)
                .background(Color.grayLight)
                .cornerRadius(5.0)
                .padding()
            //    .textFieldStyle(.roundedBorder)
            
            ZStack{
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .frame(width: 340,height: 40)
                    .shadow(radius: 4)
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 170, height: 36)
                    .offset(x: currentMode == .temporary ? -82 : 82)
                    .foregroundColor(Color.accentColor)
                    .animation(Animation.easeInOut(duration: 0.3), value: currentMode)
                HStack{
                    Spacer()
                    Button(action: {currentMode = .temporary}, label: {
                        Text("Temporaire")
                            .font(.headline)
                            .foregroundColor(currentMode == .temporary ? .white : Color.grayDark)
                            .frame(width: 170)
                    })
                    Button(action: {currentMode = .permanent}, label: {
                        Text("Permanent")
                            .font(.headline)
                            .foregroundColor(currentMode == .permanent ? .white : Color.grayDark)
                            .frame(width: 170)
                    })
                    Spacer()
                    
                }
            }
            
           
            if currentMode == .temporary {
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


#Preview {
    CreateActivityView(activityCategory: .nature)
}
