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


    
    var body: some Scene {
        WindowGroup {
            HomepageView()
                // lancement du call API au niveau de la vue inti de l'app
                .onAppear{
                Task{
                    userGlobalVariables.allUsers = await userGlobalVariables.fetchedUser()
                    userGlobalVariables.connectedUser = userGlobalVariables.allUsers[4]
                    activityGlobalVariables.allActivities = await activityGlobalVariables.fetchedActivity()
                }
            }
        }
        .environmentObject(searchGlobalVariables)
        .environmentObject(userGlobalVariables)
        .environmentObject(activityGlobalVariables)
    }
}

