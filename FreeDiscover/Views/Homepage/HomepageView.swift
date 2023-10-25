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
    @State var showSearchModal : Bool = false
    @State var showCarroussel : Bool = true

    
    var body: some View {
        NavigationView{
            ZStack{
                //map
                if(currentDisplayMode == .map){
                    MapView()
                }
                if(currentDisplayMode == .list){
                    ListView()
                }
                VStack {
                    HStack{
                        SearchButton(showSearchModal: $showSearchModal)
                        Spacer()
                        DisplaySwitchButton(displayMode: $currentDisplayMode)
                        Spacer()
                        ProfileButton()
                    }
                    .padding()
                    Spacer()
                    if(currentDisplayMode == .map){
                        CarrousselBonPlan()
                    }
                }
//
                //gestion de l'affichage de la modale searchView
                .sheet(isPresented: $showSearchModal){
                    SheetViewShearch()
                }
                
            }
        }
    }
}

#Preview {
    HomepageView()
}
