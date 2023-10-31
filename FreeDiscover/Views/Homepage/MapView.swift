//
//  MapView.swift
//  FreeDiscover
//
//  Created by apprenant 101 on 24/10/2023.
//

// MARK: - MapView

/*
 Abstract:
 `MapView` Représente la vue plan de freeDicover.
 */

import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
    // MARK: Variables locales à la vue
    //Instance de notre class
    @StateObject var locationManager = LocationManager()
    
    /// Propriété d'état qui stocke qui ajuste la postion de la caméra sur la région de l'utilisateur.
    @State private var cameraPosition: MapCameraPosition = .region(.userRegion)
    
    /// Propriété d'état d'un tableau avec toutes les activtés de freeDiscover à épingler sur la map à l'ouverture de l'app.
    @State private var freeDiscover: [FreeDiscover] = FreeDiscover.allFreeDiscover
    
    /// Propriété d'état contrôlant l'affcihage de la modal `SheetViewSearch`.
    @State private var isShowingSheetViewSearch: Bool = true
    
    /// variable à utiliser pour authoriser la sélection d'item sur la map
    @State private var selectedTag : Int?
    
    // MARK: Variables héritées d'autres vues
    /// Gestion affichage de la modale  activity preview
    @Binding var showActivityPreview : Bool
      
    /// Importation des variables globales
    @EnvironmentObject var globalVariables : SearchGlobalVariables
    
    // MARK: Fonctions de la vue
    /// Fonction de recherche appliquée à la map
    func searchActivities() {
        globalVariables.searchResults = FreeDiscover.allFreeDiscover.filter(searchText: globalVariables.searchContent,lookForNature: globalVariables.isNatureSelectedForSearch,lookForSport: globalVariables.isSportSelectedForSearch,lookForCulture: globalVariables.isCultureSelectedForSearch,lookForSocial: globalVariables.isSocialSelectedForSearch)
    }
    
    // MARK: VUE
    var body: some View {
        /// 1) - Map
        Map(position: $cameraPosition,selection: $selectedTag) {
            
            /// Affiche l'emplacement actuelle de l'utilisateur sur la carte.
            UserAnnotation()
            
            // Si pas de recherche en cours, affichage des activités en BDD
            if(globalVariables.isSearchOngoing == false){
                ForEach(freeDiscover.indices, id:\.self){index in
                    Annotation(
                        "\(freeDiscover[index].name)",
                        coordinate: freeDiscover[index].location,
                        anchor: .center
                    
                    ){
                        ActivitySymbol(activityType: freeDiscover[index].type.rawValue, temporary: freeDiscover[index].temporary)
                            .scaleEffect(selectedTag == index ? 1.2 : 1)
                        
                    }
                    .tag(index)
                }
            }
            if(globalVariables.isSearchOngoing == true){
                ForEach(globalVariables.searchResults.indices, id:\.self){index in
                    Annotation(
                        "\(globalVariables.searchResults[index].name)",
                        coordinate: globalVariables.searchResults[index].location,
                        anchor: .center
                    
                    ){
                        ActivitySymbol(activityType: globalVariables.searchResults[index].type.rawValue, temporary: globalVariables.searchResults[index].temporary)
                            .scaleEffect(selectedTag == index ? 1.2 : 1)
                        
                    }
                    .tag(index)
                }
            }
            
            
        }
        
        /// Génération d'espaces vides en haut et à droite pour décaler les boutons mapControl
        .safeAreaInset(edge: .top){
            Rectangle()
                .frame(height:40)
                .opacity(0)
        }
        .safeAreaInset(edge: .trailing){
            Rectangle()
                .frame(width: 3)
                .opacity(0)
        }
        /// 3) - Bouton pour le contrôle de la map pour l'utilisateur.
        .mapControls {
            MapUserLocationButton()
            MapPitchToggle()
            MapCompass()
            
        }
        .mapControlVisibility(.visible)
        
        ///Quand la vue apparait on est notifié de la permission
        .onAppear(perform: {
            locationManager.requestLocation()
        })
        .onChange(of: selectedTag){
            /// Définie l'objet sélectionné dans les variables globales et à afficher dans `activityPreview`
            globalVariables.selectedActivityInSearch = globalVariables.isSearchOngoing ? globalVariables.searchResults[selectedTag!] : freeDiscover[selectedTag!]
            /// Affiche la modale `activityPreview`
            showActivityPreview = true
        }
        .onChange(of: globalVariables.launchSearch){
            searchActivities()
        }
    }
}
//}

#Preview {
    MapView(showActivityPreview: .constant(false)).environmentObject(SearchGlobalVariables())
}

// MARK: Extentions
/// Une extension qui contient l'emplacement géographique de l'utilisateur.
extension CLLocationCoordinate2D {
    static var userLocation = CLLocationCoordinate2D(
        latitude: 43.296367,
        longitude: 5.368363)
}

/// Une extension qui définie le niveau du zoom souhiaté sur la carte.
extension MKCoordinateSpan {
    static var userRegionSpan: MKCoordinateSpan {
        return.init(latitudeDelta: 0.010, longitudeDelta: 0.010)
    }
}

/// Une extension de la région géographique spécifique.
extension MKCoordinateRegion {
    static let userRegion = MKCoordinateRegion(center: .userLocation, latitudinalMeters: 10000, longitudinalMeters: 10000)
}
