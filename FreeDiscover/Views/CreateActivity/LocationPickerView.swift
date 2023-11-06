//
//  LocationPickerView.swift
//  FreeDiscover
//
//  Created by apprenant92 on 30/10/2023.
//

import SwiftUI
import MapKit
import CoreLocation

struct NewLocation: Identifiable, Codable, Equatable {
    let id: UUID
    var newLatitude: Double
    var newLongitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: newLatitude, longitude: newLongitude)
    }
}

struct LocationPickerView: View {
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 43.296367, longitude: 5.368363), span: MKCoordinateSpan(latitudeDelta: 0.080, longitudeDelta: 0.080))
    @StateObject var locationManager = LocationManager()
    @State private var cameraPosition: MapCameraPosition = .region(.userRegion)
    @State private var locations = [NewLocation]()
    @Environment(\.presentationMode) var presentationMode
    @State var showingAlertLocation = false
    
    @Binding var latitude : Double
    @Binding var longitude : Double

    
    var body: some View {
        VStack {
            ZStack {
                Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
                    MapMarker(coordinate: CLLocationCoordinate2D(latitude: location.newLatitude, longitude: location.newLongitude))
                }
                .mapControls {
                    MapUserLocationButton()
                    MapPitchToggle()
                    MapCompass()
                    
                }
                .mapControlVisibility(.visible)
                .frame(height: 300)
                .onAppear(perform: {
                    locationManager.requestLocation()
                })
                Circle()
                    .fill(.blue)
                    .opacity(0.3)
                    .frame(width: 32, height: 32)
            }
                VStack {
                    Button {
                        @State var newLocation = NewLocation(id: UUID(), newLatitude: mapRegion.center.latitude, newLongitude: mapRegion.center.longitude)
                        locations.append(newLocation)
                        latitude = newLocation.newLatitude
                        longitude = newLocation.newLongitude
//                        var coordinate = newLocation.coordinate
                        print(newLocation.newLatitude)
                        print(newLocation.newLongitude)
                        presentationMode.wrappedValue.dismiss()
                        showingAlertLocation = true
                        
                    } label: {
                        Text("Sélectionner cet emplacement")
                        
                    }
                    .alert(isPresented: $showingAlertLocation) {
                                Alert(title: Text("Emplacement sélectionné"), message: Text(""), dismissButton: .default(Text("OK")))
                            }
                }
            
    }
}
}



#Preview {
    LocationPickerView(latitude: .constant(0.0), longitude: .constant(0.0))
}
