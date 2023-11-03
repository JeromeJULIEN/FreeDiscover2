//
//  FavoritesManager.swift
//  FreeDiscover
//
//  Created by apprenant92 on 31/10/2023.
//

import SwiftUI

struct FavoritesManager {
    @EnvironmentObject var userGlobalVariables : APIUserRequestModel
    
    
    // Functions to add and remove from cart
    func addToFavorites(activityId : Int) {
        userGlobalVariables.connectedUser.idFromFavorite.append(activityId)
    }
    func removeFromFavorites(activityId : Int) {
        userGlobalVariables.connectedUser.idFromFavorite = userGlobalVariables.connectedUser.idFromFavorite.filter { $0 != activityId }
    }
}
