//
//  ActivityTypes.swift
//  FreeDiscover
//
//  Created by apprenant 101 on 19/10/2023.
//

// MARK: - ActivityTypes

/*
 Abstract:
  `ActivityTypes` Type de modèle d'une énumération qui représente les différentes activités.
 */

import SwiftUI

/// Un modèle d'énumération qui fournit une valeur sur l'activité.
///
/// `activityTypes` : Founit une catégories recommandée pour aider l'utilisateur à choisir sont activité.
///
/// Cette énumaération se conforme au protocole standard `String`.
///
enum ActivityTypes : String, CaseIterable {
    case nature = "nature"
    case culture = "culture"
    case sport = "sport"
    case social = "social"

}
