//
//  FavoritesManager.swift
//  FreeDiscover
//
//  Created by apprenant92 on 31/10/2023.
//

import SwiftUI

struct FavoritesManager {
    @EnvironmentObject var userGlobalVariables : UserGlobalVariables
    
    
    // Functions to add and remove from cart
    func addToFavorites(activityId : Int) {
        userGlobalVariables.connectedUser.userFavorites.append(activityId)
    }
    func removeFromFavorites(activityId : Int) {
        userGlobalVariables.connectedUser.userFavorites = userGlobalVariables.connectedUser.userFavorites.filter { $0 != activityId }
    }
}
