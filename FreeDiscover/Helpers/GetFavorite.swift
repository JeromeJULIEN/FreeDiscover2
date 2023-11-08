//
//  GetFavorite.swift
//  FreeDiscover
//
//  Created by apprenant58 on 24/10/2023.
//

import Foundation


/// Fonction pour retrouver les activités favorites de l'utilisateur connecté dans un tableau d'activité
func getFavoriteFromUserByType(activityDataBase: [Activity], userFavorites : [Int],type : String)->[Activity]{
    var filteredArray = [Activity] ()
    filteredArray = activityDataBase.filter {activity in
        userFavorites.contains(activity.id) && activity.typeActivite == type
    }
    return filteredArray
}
