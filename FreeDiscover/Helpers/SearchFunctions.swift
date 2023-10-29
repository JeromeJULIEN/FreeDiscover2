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
extension Array where Element == FreeDiscover {
    /// Renvoie une liste d'activités dont le champ `summary` contient au moins un des mots spécifiés.
    func filter(searchText: String) -> [FreeDiscover] {
        let searchWords = searchText.split(separator: " ").map { String($0) }
        return self.filter { $0.summary.containsAny(of: searchWords) }
    }
}

/// 3 - La fonction de recherche `searchActivities()` est définie et déclenchée dans les vue `MapView` et `ListView` en s'appuyant sur les 2 fonctions définies ci dessus
