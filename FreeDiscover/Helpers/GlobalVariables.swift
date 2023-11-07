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
    @Published var searchResults : [Activity] = []
    /// Activité sélectionnée dans la vue map
    @Published var selectedActivityInSearch = Activity.nature1
    /// Filtre par catégorie pour la recherche
    @Published var isNatureSelectedForSearch : Bool = false
    @Published var isSportSelectedForSearch : Bool = false
    @Published var isCultureSelectedForSearch : Bool = false
    @Published var isSocialSelectedForSearch : Bool = false

}


