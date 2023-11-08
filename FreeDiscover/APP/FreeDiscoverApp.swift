//
//  FreeDiscoverApp.swift
//  FreeDiscover
//
//  Created by jerome julien on 19/10/2023.
//

import SwiftUI


@main

struct FreeDiscoverApp: App {
    
    // Définition des variables d'environnement pour les rendre dispo dans toute l'application
    @StateObject var searchGlobalVariables = SearchGlobalVariables()
    @StateObject var userGlobalVariables = APIUserRequestModel()
    @StateObject var activityGlobalVariables = APIActivityRequestModel()
    
    /// Variable pour gérer l'affichage de la page de chargement
    @State private var isLoadingComplete = false
    


    
    var body: some Scene {
        WindowGroup {
                    ZStack {
                        // Vue de chargement toujours présente mais cachée quand le chargement est terminé
                        LoadingScreen()
                            .opacity(isLoadingComplete ? 0 : 1)
                            .animation(.easeInOut(duration: 0.5), value: isLoadingComplete)
                        
                        // Vue principale qui deviendra visible quand le chargement est terminé
                        if isLoadingComplete {
                            HomepageView()
                        }
                    }
                    .task {
                        /// Appel des fonctions de `GET API`
                        await loadData()
                    }
                }
            .environmentObject(searchGlobalVariables)
            .environmentObject(userGlobalVariables)
            .environmentObject(activityGlobalVariables)
        }

    
        // Fonction d'appel des GET API : GET activité et GET users
        /// Les fonctions sont définies dans les fichiers `APIRequestModel`
        /// Les données reçues sont stockées dans les StateObject définis plus haut
        private func loadData() async {
            (userGlobalVariables.allUsers, userGlobalVariables.allUsersRecord) = await userGlobalVariables.fetchedUser()
            userGlobalVariables.connectedUser = userGlobalVariables.allUsers[0] // Utilisez une valeur par défaut si nécessaire
            (activityGlobalVariables.allActivities, activityGlobalVariables.allActivitiesRecord) = await activityGlobalVariables.fetchedActivity()
            /// on informe de la fin de la récupération des données pour afficher la vue `homepage`
            isLoadingComplete = true
        }
}



