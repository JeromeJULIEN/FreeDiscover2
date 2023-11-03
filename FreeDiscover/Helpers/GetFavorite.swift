//
//  GetFavorite.swift
//  FreeDiscover
//
//  Created by apprenant58 on 24/10/2023.
//

import Foundation

//@dev : function to filter all the temporary Activities of the data base
//func getFavorite(type: ActivityTypes) -> [FreeDiscover] {
//    var filteredArray = [FreeDiscover] ()
//    filteredArray = FreeDiscover.allFreeDiscover.filter {
//        $0.favorite == true && $0.type == type }
//    return filteredArray
//}
//


func getFavoriteFromUserByType(activityDataBase: [Activity], userFavorites : [Int],type : String)->[Activity]{
    var filteredArray = [Activity] ()
    filteredArray = activityDataBase.filter {activity in
        userFavorites.contains(activity.id) && activity.typeActivite == type
    }
    return filteredArray
}
