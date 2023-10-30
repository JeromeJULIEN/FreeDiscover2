//
//  FreeDiscoverApp.swift
//  FreeDiscover
//
//  Created by jerome julien on 19/10/2023.
//

import SwiftUI


@main
struct FreeDiscoverApp: App {
    
    // Importation des variables d'environnement de l'application
    @StateObject var globalVariables = GlobalVariables()

    
    var body: some Scene {
        WindowGroup {
            HomepageView()
        }.environmentObject(globalVariables)
    }
}
