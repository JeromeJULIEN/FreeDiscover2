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
    
    @EnvironmentObject var globalVariables : SearchGlobalVariables
    
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
                    if(globalVariables.isSearchOngoing == true){
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

                .sheet(isPresented: $showCarroussel){
                    CarrousselBonPlan()
                        .sheet(isPresented: $showActivityPreview){
                            ActivityPreview(activity: globalVariables.selectedActivityInSearch)
                        }
                }
                .sheet(isPresented: $showActivityPreview){
                    ActivityPreview(activity: globalVariables.selectedActivityInSearch)
                }
                .overlay(alignment: .top, content: {
                    SearchView(showSearchView: $showSearchView)
                })
            }
        }
    }
}

#Preview {
    HomepageView().environmentObject(SearchGlobalVariables())
}
