//
//  FreeDiscoverApp.swift
//  FreeDiscover
//
//  Created by jerome julien on 19/10/2023.
//

import SwiftUI


@main
struct FreeDiscoverApp: App {
    
    // Importation des variables d'environnement pour les rendre dispo dans toute l'application
    @StateObject var searchGlobalVariables = SearchGlobalVariables()
    @StateObject var userGlobalVariables = APIUserRequestModel()
    @StateObject var activityGlobalVariables = ActivityGlobalVariables()


    
    var body: some Scene {
        WindowGroup {
            HomepageView()
        }
        .environmentObject(searchGlobalVariables)
        .environmentObject(userGlobalVariables)
        .environmentObject(activityGlobalVariables)
        
    }
}
