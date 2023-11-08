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
    // MARK: Importation des variables globales
    @EnvironmentObject var searchGlobalVariables : SearchGlobalVariables
    @EnvironmentObject var activityGlobalVariables : APIActivityRequestModel
    
    // MARK: Variables locales à la vue
    /// Instance de notre class LocationManager qui permet de gérer les fonctions de la carte
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
    
    
    // MARK: Fonctions de la vue
    /// Fonction de recherche appliquée à la map
    func searchActivities() {
        searchGlobalVariables.searchResults = activityGlobalVariables.allActivities.filter(searchText: searchGlobalVariables.searchContent,lookForNature: searchGlobalVariables.isNatureSelectedForSearch,lookForSport: searchGlobalVariables.isSportSelectedForSearch,lookForCulture: searchGlobalVariables.isCultureSelectedForSearch,lookForSocial: searchGlobalVariables.isSocialSelectedForSearch)
    }
    
    /// fonction pour calculer la nouvelle zone d'affichage en fonction des résultats de recherche
    func regionForSearchResults(_ searchResults: [Activity]) -> MKCoordinateRegion {
        let latitudes = searchResults.map { $0.latitude }
        let longitudes = searchResults.map { $0.longitude }
        
        let maxLat = latitudes.max() ?? 0
        let minLat = latitudes.min() ?? 0
        let maxLong = longitudes.max() ?? 0
        let minLong = longitudes.min() ?? 0
        /// ajout d'un espace en bas pour ne pas être derrière le carroussel
//        minLat -= 0.05
        
        let center = CLLocationCoordinate2D(
            latitude: (maxLat + minLat) / 2,
            longitude: (maxLong + minLong) / 2
        )
        
        let span = MKCoordinateSpan(
            latitudeDelta: (maxLat - minLat) * 2.5, // 10% extra space
            longitudeDelta: (maxLong - minLong) * 2.5 // 10% extra space
        )
        
        return MKCoordinateRegion(center: center, span: span)
    }
    
    
    // MARK: VUE
    var body: some View {
        /// 1) - Map
        Map(position: $cameraPosition,selection: $selectedTag) {
            
            /// Affiche l'emplacement actuelle de l'utilisateur sur la carte.
            UserAnnotation()
            
            // Si pas de recherche en cours, affichage des activités en BDD
            if(searchGlobalVariables.isSearchOngoing == false){
                ForEach(activityGlobalVariables.allActivities.indices, id:\.self){index in
                    Annotation(
                        "\(activityGlobalVariables.allActivities[index].name)",
                        coordinate:CLLocationCoordinate2D(latitude: activityGlobalVariables.allActivities[index].latitude, longitude: activityGlobalVariables.allActivities[index].longitude),
                        anchor: .center
                    
                    ){
                        ActivitySymbol(activityType: activityGlobalVariables.allActivities[index].typeActivite, temporary: activityGlobalVariables.allActivities[index].temporaire)
                            .scaleEffect(selectedTag == index ? 1.2 : 1)
                        
                    }
                    .tag(index)
                }
            }
            // Si recherche en cours, affichage des résultats de la recherche
            if(searchGlobalVariables.isSearchOngoing == true){
                ForEach(searchGlobalVariables.searchResults.indices, id:\.self){index in
                    Annotation(
                        "\(searchGlobalVariables.searchResults[index].name)",
                        coordinate:
                            CLLocationCoordinate2D(latitude: searchGlobalVariables.searchResults[index].latitude, longitude: searchGlobalVariables.searchResults[index].longitude),
                        anchor: .center
                        
                    
                    ){
                        ActivitySymbol(activityType: searchGlobalVariables.searchResults[index].typeActivite, temporary: searchGlobalVariables.searchResults[index].temporaire)
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
        .gesture(
            TapGesture()
                .onEnded { _ in
                    selectedTag = nil
                }
        )
        /// On réagit à la sélection d'une activité sur la carte
        .onChange(of: selectedTag) { newSelectedTag in
            if let selectedTag = newSelectedTag {
                let selectedActivity: Activity
                        if searchGlobalVariables.isSearchOngoing {
                            selectedActivity = searchGlobalVariables.searchResults[selectedTag]
                        } else {
                            selectedActivity = activityGlobalVariables.allActivities[selectedTag]
                        }
                
                        // Mise à jour de la position de la caméra pour centrer sur les coordonnées de l'activité sélectionnée
                        /// Définition du niveau de zoom
                        let zoomLevel = MKCoordinateSpan(
                            latitudeDelta: 0.05, // Plus petite valeur pour plus de zoom
                            longitudeDelta: 0.05 // Plus petite valeur pour plus de zoom
                        )
                        /// Définition de la nouvelle zone d'affichage
                        let newRegion = MKCoordinateRegion(
                            center: CLLocationCoordinate2D(
                                latitude: selectedActivity.latitude,
                                longitude: selectedActivity.longitude
                            ),
                            span: zoomLevel
                        )
                        /// Transition par animation
                        withAnimation(.easeInOut(duration: 1.0)) {
                            cameraPosition = .region(newRegion)
                        }
                        
                        // Set the selected activity and show the ActivityPreview
                        searchGlobalVariables.selectedActivityInSearch = selectedActivity
                        showActivityPreview = true
            } else {

                showActivityPreview = false
            }
        }
        /// On réagit au lancement de la recherche pour ajuster la position de la carte
        .onChange(of: searchGlobalVariables.launchSearch){
            searchActivities()
            
            let newRegion = regionForSearchResults(searchGlobalVariables.searchResults)
                
            withAnimation(.easeInOut(duration: 1.0)) {
                cameraPosition = .region(newRegion)
            }
            
        }
        
        .onChange(of: searchGlobalVariables.isSearchOngoing) { isSearchActive in
            // Reset selectedTag when the search state changes to clear the selection
            selectedTag = nil
            if !isSearchActive {
                    // Annulation de la recherche, recentrer sur la région initiale
                    withAnimation(.easeInOut(duration: 1.0)) {
                        cameraPosition = .region(.userRegion)
                    }
                }
            
        }
    }
}
//}

#Preview {
    MapView(showActivityPreview: .constant(false)).environmentObject(SearchGlobalVariables()).environmentObject(APIActivityRequestModel())
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
