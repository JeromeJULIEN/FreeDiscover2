//
//  GlobalVariables.swift
//  FreeDiscover
//
//  Created by jerome julien on 27/10/2023.
//

import Foundation

// MARK: Fichier regroupant l'ensemble des variables devant être accessible dans toute l'application

// Variables liées à la recherche
class SearchGlobalVariables :ObservableObject {
    /// Variable servant à lancer une recherche
    @Published var launchSearch : Bool = true
    /// Contenu du champ de recherche textuel
    @Published var searchContent : String = ""
    /// Booléen indiquant si une recherche est en cours
    @Published var isSearchOngoing : Bool = false
    /// Resultat de la recherche en cours
    @Published var searchResults : [FreeDiscover] = []
    /// Activité sélectionnée dans la vue map
    @Published var selectedActivityInSearch = FreeDiscover()
    /// Filtre par catégorie pour la recherche
    @Published var isNatureSelectedForSearch : Bool = true
    @Published var isSportSelectedForSearch : Bool = true
    @Published var isCultureSelectedForSearch : Bool = true
    @Published var isSocialSelectedForSearch : Bool = true

}

// Variables liées au user connecté
class UserGlobalVariables : ObservableObject {
    /// User par défaut pour lancer l'app
    @Published var connectedUser : UserProfile = UserProfile.marion
}
