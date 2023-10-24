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
    @State private var currentMode: DurationMode = .temporary
    //  @State private var currentCategory: CategoryMode = .nature
    @State private var currentActivityType = "Nature"
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
            ZStack{
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 346,height: 44)
                    .shadow(radius: 4)
                    .foregroundColor(.white)
                    // RoundedRectangle(cornerRadius: 25)
                //    .frame(width: 60, height: 36)
                //    .offset(x: activityCategory == .nature ? -102 : 102)
                 //   .foregroundColor(Color.accentColor)
                HStack{
                    
                    Button(action: {activityCategory = .nature}, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 80, height: 40)
                                .foregroundColor(activityCategory == .nature ? .accentColor : Color.clear)
                            VStack {
                                Image(systemName: "leaf")
                                    .foregroundColor(activityCategory == .nature ? .white : Color.grayDark)
                                Text("Nature")
                                    .font(.footnote)
                                    .bold()
                                    .foregroundColor(activityCategory == .nature ? .white : Color.grayDark)
                                    .frame(width: 80)
                                
                            }
                        }
            
                    })
                    Button(action: {activityCategory = .culture}, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 80, height: 40)
                                .foregroundColor(activityCategory == .culture ? .accentColor : Color.clear)
                            VStack {
                                Image(systemName: "building.columns")
                                    .foregroundColor(activityCategory == .culture ? .white : Color.grayDark)
                                Text("Culture")
                                    .font(.footnote)
                                    .bold()
                                    .foregroundColor(activityCategory == .culture ? .white : Color.grayDark)
                                    .frame(width: 80)
                                
                            }
                        }
            
                    })
                    Button(action: {activityCategory = .sport}, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 80, height: 40)
                                .foregroundColor(activityCategory == .sport ? .accentColor : Color.clear)
                            VStack {
                                Image(systemName: "figure.walk")
                                    .foregroundColor(activityCategory == .sport ? .white : Color.grayDark)
                                Text("Sport")
                                    .font(.footnote)
                                    .bold()
                                    .foregroundColor(activityCategory == .sport ? .white : Color.grayDark)
                                    .frame(width: 80)
                                
                            }
                        }
            
                    })
                    Button(action: {activityCategory = .social}, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 80, height: 40)
                                .foregroundColor(activityCategory == .social ? .accentColor : Color.clear)
                            VStack {
                                Image(systemName: "figure.socialdance")
                                    .foregroundColor(activityCategory == .social ? .white : Color.grayDark)
                                Text("Social")
                                    .font(.footnote)
                                    .bold()
                                    .foregroundColor(activityCategory == .social ? .white : Color.grayDark)
                                    .frame(width: 80)
                                
                            }
                        }
            
                    })
                    
                 
                    
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
        
   
        TextField(("Nom de l'activité"), text: $activityName)
            .padding()
            .background(Color.grayLight)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
        TextField(("Description de l'activité"), text: $activityDescription, axis: .vertical)
            .lineLimit(3)
            .padding()
            .background(Color.grayLight)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
        //    .textFieldStyle(.roundedBorder)
        
        
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
        HStack {
            Button(action: {
                self.symbolSelection = 1
            }) {
                AccessibilitySymbol(symbolSelection: 2, accessSymbol: "figure.2.and.child.holdinghands", accessName: "Familiale")
            }
            Button(action: {
                self.symbolSelection = 0
            }) {
                AccessibilitySymbol(symbolSelection: 0, accessSymbol: "figure.roll", accessName: "Accessible")
            }
            
        }
        Spacer()
       
    }
}


#Preview {
    CreateActivityView(activityCategory: .nature)
}
