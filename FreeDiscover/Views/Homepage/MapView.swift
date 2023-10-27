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
    
    /// Propriété d'état d'un tableau avec toutes les activtés de freeDiscover à épingler sur la map.
    @State private var freeDiscover: [FreeDiscover] = FreeDiscover.allFreeDiscover
    
    /// Propriété d'état contrôlant l'affcihage de la modal `SheetViewSearch`.
    @State private var isShowingSheetViewSearch: Bool = true
    
    // variable à utiliser pour authoriser la sélection d'item sur la map
    @State private var selectedTag : Int?
    
    // MARK: Variables héritées d'autres vues
    /// Gestion affichage de la modale  activity preview
    @Binding var showActivityPreview : Bool
      
    /// Importation des variables globales
    @EnvironmentObject var globalVariables : GlobalVariables
    
       
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
            showActivityPreview = true
        }
        .onChange(of: globalVariables.launchSearch){
            searchActivities()
        }
    }
}
//}

#Preview {
    MapView(showActivityPreview: .constant(false)).environmentObject(GlobalVariables())
}

// MARK: logique de recherche
/// 1- extension du Type string pour rajouter une fonction `containsAny(of)` de recherche avec un ensemble de mot
extension String {
    /// Vérifie si la chaîne contient au moins un des mots spécifiés.
    func containsAny(of words: [String]) -> Bool {
        for word in words {
            if self.localizedCaseInsensitiveContains(word) {
                return true
            }
        }
        return false
    }
}

/// extension du type array (restraint aux array d'élément de type FreeDiscover) pour ajouter la fonction `filter` qui s'appuie sur `containsAny()`
extension Array where Element == FreeDiscover {
    /// Renvoie une liste d'activités dont le champ `summary` contient au moins un des mots spécifiés.
    func filter(searchText: String) -> [FreeDiscover] {
        let searchWords = searchText.split(separator: " ").map { String($0) }
        return self.filter { $0.summary.containsAny(of: searchWords) }
    }
}

/// Extension pour la classe `mapView` pour ajouter la fonction `searchActivities()` pour appeler la fonction `filter`
extension MapView {
    func searchActivities() {
        globalVariables.searchResults = FreeDiscover.allFreeDiscover.filter(searchText: globalVariables.searchContent)
    }
}

// MARK: extentions pour la map
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
