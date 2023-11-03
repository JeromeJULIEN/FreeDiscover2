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
                    HStack{
                        SearchButton(showSearchModal: $showSearchView)
                        Spacer()
                        DisplaySwitchButton(displayMode: $currentDisplayMode, showCarroussel: $showCarroussel)
                        Spacer()
                        ProfileButton(showCarroussel: $showCarroussel)
                    }
                    .padding(.horizontal)
                    .padding(.bottom,1)
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
                            }
                            
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
                                    .animation(.easeInOut)
                                   // .zIndex(1)
                                    .background(Color.white)
                                 //   .opacity(0.8)
                                    .frame(maxWidth: .infinity, maxHeight: 200, alignment: .bottom)
                                    
                                    .overlay(
                                    Button(action: {
                                    showCarroussel = false
                                    }) {
                                        Image(systemName: "x.circle.fill")
                                            .foregroundColor(.grayDark)
                                    }
                                    .padding(0)
                                    .shadow(radius: 1)
                                  //  .opacity(0.8)
                                    , alignment: .topTrailing)
                              //  .frame(width: 150, height: 150)
                                .clipShape(RoundedRectangle(cornerRadius:10))
                                
                            }
                           
                        }
                       
                        
                    }
                        
                    
                }
                .edgesIgnoringSafeArea(.bottom)
               
                
                
                .overlay(alignment: .bottomLeading) {
                    Group {
                        if showActivityPreview {
                            ZStack(alignment: .bottom) {
                                NavigationLink(destination:ActivityDetailView(activity: searchGlobalVariables.selectedActivityInSearch)){
                                    
                                    ListCard(activity: searchGlobalVariables.selectedActivityInSearch)
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
                                    }
                                    .padding(0)
                                    .shadow(radius: 1)
                                  //  .opacity(0.8)
                                    , alignment: .topTrailing)
                              //  .frame(width: 150, height: 150)
                                .clipShape(RoundedRectangle(cornerRadius:10))
                                    
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
