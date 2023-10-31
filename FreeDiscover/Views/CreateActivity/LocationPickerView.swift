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
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

struct LocationPickerView: View {
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 43.296367, longitude: 5.368363), span: MKCoordinateSpan(latitudeDelta: 0.080, longitudeDelta: 0.080))
    @StateObject var locationManager = LocationManager()
    @State private var cameraPosition: MapCameraPosition = .region(.userRegion)
    @State private var locations = [NewLocation]()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            ZStack {
                Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
                    MapMarker(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
                }
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
                        let newLocation = NewLocation(id: UUID(), latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
                        locations.append(newLocation)
                        var coordinate = newLocation.coordinate
                        print(newLocation.coordinate)
                        presentationMode.wrappedValue.dismiss()
                        
                    } label: {
                        Text("Sélectionner cet emplacement")
                        
                    }
                }
            
    }
}
}



#Preview {
    LocationPickerView()
}
