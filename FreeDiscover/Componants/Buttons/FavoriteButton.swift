//
//  FavoriteButton.swift
//  FreeDiscover
//
//  Created by jerome julien on 31/10/2023.
//

import SwiftUI

struct FavoriteButton: View {
     
    // MARK: Variables externes à la vue
    @EnvironmentObject var userGlobalVariables : APIUserRequestModel
    /// Id de l'activité à afficher
    var activityId : Int
    /// Fonction pour vérifier si l'activité est dans les favoris du user connecté
    func isFavorite(activityId : Int) -> Bool {
        return userGlobalVariables.connectedUser.idFromFavorite.contains(activityId)
    }
    /// Fonctions pour ajouter ou supprimer un favori
    func addToFavorites(activityId : Int) {
        userGlobalVariables.connectedUser.idFromFavorite.append(activityId)
    }
    func removeFromFavorites(activityId : Int) {
        userGlobalVariables.connectedUser.idFromFavorite = userGlobalVariables.connectedUser.idFromFavorite.filter { $0 != activityId }
    }
    
    var body: some View {
        Button(action :
                /// action conditionnelle en fonction de si l'activité est déjà dans les fav ou non
                {isFavorite(activityId: activityId) ? 
                /// action si true
                Task{
                    do{
                        try await userGlobalVariables.addFavoriteToUser(userId: userGlobalVariables.connectedUser.id, currentFavorites: userGlobalVariables.connectedUser.idFromFavorite, favoriteToAdd: activityId)
                    }
                }                :
                /// action si false
                Task{
                    do{
                        try await userGlobalVariables.addFavoriteToUser(userId: userGlobalVariables.connectedUser.id, currentFavorites: userGlobalVariables.connectedUser.idFromFavorite, favoriteToAdd: activityId)
                    }
                }
                }){
            ZStack {
                Image(systemName: "heart.fill")
                    .padding(4)
                    .foregroundStyle(.accent)
                    .opacity(isFavorite(activityId: activityId) ? 1 : 0)
                    .bold()
                    .font(.title2)
                Image(systemName: "heart")
                    .padding(4)
                    .foregroundStyle(.white)
                    .bold()
                    .font(.title2)
            }
            
        }
    }
}

#Preview {
    FavoriteButton(activityId: 1).environmentObject(APIUserRequestModel())
}
