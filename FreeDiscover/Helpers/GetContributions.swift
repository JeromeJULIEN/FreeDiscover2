//
//  GetContributions.swift
//  FreeDiscover
//
//  Created by apprenant58 on 02/11/2023.
//

import Foundation

/// Fonction pour retrouver les contribution de l'utilisateur connecté dans un tableau d'activité
func getContributionFromUserByType(activityDataBase: [Activity], userContribution : [Int],type : String)->[Activity]{
    var filteredArray = [Activity] ()
    filteredArray = activityDataBase.filter {activity in
        userContribution.contains(activity.id) && activity.typeActivite == type
    }
    return filteredArray
}

