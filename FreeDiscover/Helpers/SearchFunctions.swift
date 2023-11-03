//
//  SearchFunctions.swift
//  FreeDiscover
//
//  Created by jerome julien on 29/10/2023.
//

import Foundation

// MARK: logique de recherche
/// 1- extension du Type string pour rajouter une fonction `containsAny(of)` de recherche avec un ensemble de mot
extension String {
    /// Vérifie si la chaîne contient au moins un des mots spécifiés.
    func containsAny(of words: [String]) -> Bool {
        for word in words {
            if self.localizedCaseInsensitiveContains(word) {
                return true
            }
        }
        return false
    }
}

///2- extension du type array (restraint aux array d'élément de type FreeDiscover) pour ajouter la fonction `filter` qui s'appuie sur `containsAny()`

extension Array where Element == Activity {
    /// Renvoie une liste d'activités dont le champ `summary` contient au moins un des mots spécifiés et dont le type et sélectionné dans les filtres de recherche
    func filter(searchText: String, lookForNature: Bool, lookForSport : Bool, lookForCulture : Bool,lookForSocial : Bool) -> [Activity] {
        let searchWords = searchText.split(separator: " ").map { String($0) }
        return self.filter { activity in
            /// En fonction du type de l'activité, on vérifie si l'utilisateur à selectionné ce type
            let doesTypeMatch: Bool
            switch activity.typeActivite {
                   case "nature":
                       doesTypeMatch = lookForNature
                   case "sport":
                       doesTypeMatch = lookForSport
                   case "culture":
                       doesTypeMatch = lookForCulture
                   case "social":
                       doesTypeMatch = lookForSocial
                   default:
                       doesTypeMatch = false
               }
            /// Vérifiez si le titre, le résumé ou la description contiennent l'un des mots de recherche.
            let doesSummaryMatch = activity.description.containsAny(of: searchWords) || activity.name.containsAny(of: searchWords)
            /// On retourne l'activité si les deux critères sont valides
            return doesTypeMatch && doesSummaryMatch }
    }
}

/// 3 - La fonction de recherche `searchActivities()` est définie et déclenchée dans les vue `MapView` et `ListView` en s'appuyant sur les 2 fonctions définies ci dessus

