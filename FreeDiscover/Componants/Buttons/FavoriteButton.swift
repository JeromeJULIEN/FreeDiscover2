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
    @EnvironmentObject var activityGlobalVariables : APIActivityRequestModel
    /// Id de l'activité à afficher
    var activityId : Int
    
    
    
    /// fonction permettant de retrouver l'id du record de l'activité concerné
    func findActivityRecordID(activityID: Int, records: [ActivityRecord]) -> String {
        for record in records {
            if record.fields.id == activityID {
                return record.id
            }
        }
        return "nil" /// Retourne nil si aucun enregistrement correspondant n'est trouvé
    }
    // idem pour un tableau d'activité
    func findActivityRecordIDs(activityIDs: [Int], records: [ActivityRecord]) -> [String] {
        var recordIDs = [String]()
        
        // Pour chaque ID d'Activity dans le tableau d'entrée...
        for activityID in activityIDs {
            // Trouver le premier ActivityRecord dont l'ID d'Activity correspond
            // et ajouter son ID à notre tableau de sortie.
            if let recordID = records.first(where: { $0.fields.id == activityID })?.id {
                recordIDs.append(recordID)
            }
        }
        
        return recordIDs
    }
    /// idem pour user
    func findUserRecordID(userID: Int, records: [UserRecord]) -> String {
        for record in records {
            if record.fields.id == userID {
                return record.id
            }
        }
        return "nil" /// Retourne nil si aucun enregistrement correspondant n'est trouvé
    }
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
                {

                isFavorite(activityId: activityId) ?
                
                /// action si true
                Task{
                    print("isFavorite : ",isFavorite(activityId: activityId))
                    await userGlobalVariables.removeFavoriteToUser(userId: findUserRecordID(userID: userGlobalVariables.connectedUser.id, records: userGlobalVariables.allUsersRecord), currentFavorites:  userGlobalVariables.connectedUser.favorite, favoriteToRemove: findActivityRecordID(activityID: activityId, records: activityGlobalVariables.allActivitiesRecord))
                }
                :
                /// action si false
                Task{
                    print("isFavorite : ",isFavorite(activityId: activityId))
                    await userGlobalVariables.addFavoriteToUser(userId: findUserRecordID(userID: userGlobalVariables.connectedUser.id, records: userGlobalVariables.allUsersRecord), currentFavorites:  userGlobalVariables.connectedUser.favorite, favoriteToAdd: findActivityRecordID(activityID: activityId, records: activityGlobalVariables.allActivitiesRecord))
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
        .onChange(of: userGlobalVariables.needsRefresh) { newValue in
                    if newValue {
                        Task {
                            await userGlobalVariables.refreshData()
                        }
                    }
                }
    }
    
}

#Preview {
    FavoriteButton(activityId: 1)
        .environmentObject(APIUserRequestModel())
        .environmentObject(APIActivityRequestModel())
}
