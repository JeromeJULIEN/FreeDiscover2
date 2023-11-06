//
//  HomepageViewJeromeTest.swift
//  FreeDiscover
//
//  Created by jerome julien on 20/10/2023.
//

import SwiftUI
import MapKit

// Mode d'affichage possible
enum ViewMode {
    case map, list
}

struct HomepageView: View {
    // definition du mode d'affichage en map par defaut
    @State private var currentDisplayMode: ViewMode = .map
    @State var showSearchView : Bool = false
    @State var showCarroussel : Bool = true
    @State var showActivityPreview : Bool = false
    @State var selectedActivity: FreeDiscover?
    
    @EnvironmentObject var searchGlobalVariables : SearchGlobalVariables
    
    var body: some View {
        NavigationView{
            ZStack{
                
                //map
                if(currentDisplayMode == .map){
                    MapView(showActivityPreview: $showActivityPreview)
                }
                if(currentDisplayMode == .list){
                    ListView()
                }
                VStack {
                    ZStack(alignment : .top){
                        if currentDisplayMode == .list {
                            Rectangle()
                                .ignoresSafeArea()
                                .foregroundColor(.white)
                                .frame(height: 110)
                                .offset(y : -50)
                        }
                       

                            
                        HStack{
                            SearchButton(showSearchModal: $showSearchView)
                            Spacer()
                            DisplaySwitchButton(displayMode: $currentDisplayMode, showCarroussel: $showCarroussel, showActivityPreview: $showActivityPreview)
                            Spacer()
                            ProfileButton(showCarroussel: $showCarroussel)
                        }
                        .padding(.horizontal)
                        .padding(.bottom,1)
                        
                    }
                    if(searchGlobalVariables.isSearchOngoing == true){
                        HStack{
                            CancelSearchButton()
                            Spacer()
                        }
                        .padding(.leading)
                    }
                    
                    
                    
                    Spacer()
                    if(currentDisplayMode == ViewMode.map){
                        Button(action: {showCarroussel.toggle()}, label:{
                            ZStack{
                                RoundedRectangle(cornerRadius: 50)
                                    .frame(width: 260,height: 30)
                                Text("Nos bons plans du moment")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                            }
                            .offset(x: 0, y: -20)
                            
                        })
                    }
                    
                }
                
                //                .sheet(isPresented: $showCarroussel){
                //                    CarrousselBonPlan()
                //                        .sheet(isPresented: $showActivityPreview){
                //                            ActivityPreview(activity: searchGlobalVariables.selectedActivityInSearch)
                //                        }
                
                //                }
                .overlay(alignment: .bottomLeading) {
                    if showCarroussel {
                        
                        Group {
                            ZStack(alignment: .bottom) {
                                
                                CarrousselBonPlan()
                                   // .transition(.move(edge: .bottom))
                                    
                                   // .zIndex(1)
                                    .background(Color.white)
                                    .opacity(0.9)
                                    .frame(maxWidth: .infinity, maxHeight: 220, alignment: .bottom)
                                    .animation(.easeInOut)
                                    .padding([.bottom], 20)
                                    .overlay(
                                    Button(action: {
                                        showCarroussel = false
                                    }) {
                                        Image(systemName: "x.circle.fill")
                                            .foregroundColor(.grayDark)
                                            .font(.title)
                                    }
                                    .opacity(0.8)
                                   // .clipShape(RoundedRectangle(cornerRadius:10))
                                    .offset(x: 0, y: -10)
                                   // .shadow(radius: 1)
                                    , alignment: .topTrailing)
                                
                            }
                            .shadow(color: Color.grayDark, radius: 2)
                           
                        }
                       
                        
                    }
                        
                    
                }
                .edgesIgnoringSafeArea(.bottom)
               
                
                
                .overlay(alignment: .bottomLeading) {
                    Group {
                        if showActivityPreview {
                            ZStack(alignment: .bottom) {
                                NavigationLink(destination:ActivityDetailView(activity: searchGlobalVariables.selectedActivityInSearch)){
                                    
                                    ListCardLarge(activity: searchGlobalVariables.selectedActivityInSearch)
                                }.accentColor(Color.grayDark)
                                        //.background(Color.white)
                                    //    .opacity(0.8)
                                        .edgesIgnoringSafeArea(.all)
                                       // .frame(maxWidth: .infinity, maxHeight: 220, alignment: .bottom)
                                        .overlay(
                                        Button(action: {
                                            showActivityPreview = false
                                        }) {
                                            Image(systemName: "x.circle.fill")
                                                .foregroundColor(.grayDark)
                                                .font(.title)
                                        }
                                        .opacity(0.8)
                                       // .clipShape(RoundedRectangle(cornerRadius:10))
                                        .offset(x: 0, y: -10)
                                       // .shadow(radius: 1)
                                        , alignment: .topTrailing)
                                    
                            }
                        }
                    }
                    
                }
                .edgesIgnoringSafeArea(.bottom)
                .overlay(alignment: .top, content: {
                    SearchView(showSearchView: $showSearchView)
                })
            }
        }
    }
}


#Preview {
    HomepageView()
        .environmentObject(SearchGlobalVariables())
}
