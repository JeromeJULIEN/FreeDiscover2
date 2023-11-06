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
    @StateObject var searchGlobalVariables = SearchGlobalVariables() // -> local
    @StateObject var userGlobalVariables = APIUserRequestModel() // -> API
    @StateObject var activityGlobalVariables = APIActivityRequestModel() // -> local
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
                        await loadData()
                    }
                }
            .environmentObject(searchGlobalVariables)
            .environmentObject(userGlobalVariables)
            .environmentObject(activityGlobalVariables)
        }

        // Déplacez la logique de chargement des données ici
        private func loadData() async {
            (userGlobalVariables.allUsers, userGlobalVariables.allUsersRecord) = await userGlobalVariables.fetchedUser()
            userGlobalVariables.connectedUser = userGlobalVariables.allUsers[0] // Utilisez une valeur par défaut si nécessaire
            (activityGlobalVariables.allActivities, activityGlobalVariables.allActivitiesRecord) = await activityGlobalVariables.fetchedActivity()
            isLoadingComplete = true // Mettre à jour l'état de chargement
        }
}



