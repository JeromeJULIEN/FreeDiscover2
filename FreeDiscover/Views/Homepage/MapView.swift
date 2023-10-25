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
    //Instance de notre class
    @StateObject var locationManager = LocationManager()
    
    /// Propriété d'état qui stocke qui ajuste la postion de la caméra sur la région de l'utilisateur.
    @State private var cameraPosition: MapCameraPosition = .region(.userRegion)
    
    /// Propriété d'état d'un tableau avec toutes les activtés de freeDiscover à épingler sur la map.
    @State private var freeDiscover: [FreeDiscover] = FreeDiscover.allFreeDiscover
    
    /// Prorpiété d'état pour contenir le texte de recherche qu'un utiliosateur tape dans le champ de recherche.
    @State private var searchFreeDiscover = ""
    
    /// Propriété d'état contrôlant l'affcihage de la modal `SheetViewSearch`.
    @State private var isShowingSheetViewSearch: Bool = true
    
    /// Prorpiété d'état qui affiche un tableau de résultat de recherche.
    @State private var results: [FreeDiscover] = []
    
    // variable à utiliser pour authoriser la sélection d'item sur la map
    @State private var selectedTag : Int?
    
       
    var body: some View {
        /// 1) - Map
        Map(position: $cameraPosition,selection: $selectedTag) {
            
            /// Affiche l'emplacement actuelle de l'utilisateur sur la carte.
            UserAnnotation()
            
            // Affichage des activités en BDD
            ForEach(FreeDiscover.allFreeDiscover.indices, id:\.self){index in
                Annotation(
                    "\(FreeDiscover.allFreeDiscover[index].name)",
                    coordinate: FreeDiscover.allFreeDiscover[index].location,
                    anchor: .center
                
                ){
                    ActivitySymbol(activityType: FreeDiscover.allFreeDiscover[index].type.rawValue, temporary: FreeDiscover.allFreeDiscover[index].temporary)
                        .scaleEffect(selectedTag == index ? 1.2 : 1)
                    
                }
                .tag(index)
            }
            
//            Annotation("", coordinate: .userLocation) {
//                
//                /// 2) - Symbol personnalisée pour la  postion de l'utilisateur surn la carte.
//                ZStack {
//                    UserPositionSymbol()
//                }
//            }
        }
        /// 4) - Bouton qui affiche  la vue modal pour la recherche et la vue profile.
//        .safeAreaInset(edge: .top, alignment: .leading, spacing: 16) {
//            /// TODO Extraire les boutons.
//            HStack {
//                Button(action: {
//                    withAnimation {
//                        /// Todo ajouter la modalSheach Search.
//                        isShowingSheetViewSearch.toggle()
//                    }
//                }, label: {
//                    SearchButton()
//                })
//                .sheet(isPresented: $isShowingSheetViewSearch) {
//                    SheetViewShearch()
//                }
//                
//                Spacer() /// Ajouter le `segmentedPickerCustom` Liste ou plan au milieu.
//                
//                Button(action: {
//                    withAnimation {
//                        /// Todo ajouter la vue profile.
//                    }
//                }, label: {
//                    ProfileButton()
//                })
//
//            }
//            .frame(minWidth: 0,  maxWidth: .infinity, alignment: .trailing)
//            .padding()
//        }
        // Génération d'espaces vides en haut et à droite pour décaler les boutons mapControl
        .safeAreaInset(edge: .top){
            Rectangle()
                .frame(height:58)
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
        
        //Quand la vue apparait on est notifié de la permission
        .onAppear(perform: {
            locationManager.requestLocation()
        })
    }
}
//}

#Preview {
    MapView()
}

/// Extension pour la classe `mapView` pour la méthode `func` recherche d'une activité dans la région effecyuer par l'utilisateur.
///
extension MapView {
    func searchFreeDiscoverPlace() async {
        /// Référence à l'interface de la vue mapView.
        //        let mapView = MKMapView()
        
        /// Initialise `MKLocalSearch` une requête pour la recherche des emplacements (points d'intérêts) sur la carte en fonction de la recherche language naturel de l'utilisateur.
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchFreeDiscover
        searchRequest.resultTypes = .pointOfInterest
        
        /// Définit la région de la requête de recherche spécifique à l'utilisateur  sur la carte.
        searchRequest.region = .userRegion
        
        let result = try? await MKLocalSearch(request: searchRequest).start()
        /// TODO Ne pas oublier d'ajouter  le result une prorpiété MKMapItem pour l'activité dans un tableau.
        
        
        /// Initialisation de la recherche locale, basée sur la requête fournie par l'utilisateur.
        //        let search = MKLocalSearch(request: searchRequest)
        
        //        search.start { (response, error )in
        //            guard let response = response else {
        //                print("Erreur: \(error?.localizedDescription ?? "Aucune activité").")
        //                return
        //            }
        
        /// Boucle `for` pour les résultats de la recherche de l'activité.
        /// TODO Ne pas oublier d'ajouter  une prorpiété MKMapItem pour l'activité dans un tableau.
        
    }
}
//}

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
