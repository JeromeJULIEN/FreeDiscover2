//
//  APIRecordHelper.swift
//  FreeDiscover
//
//  Created by jerome julien on 05/11/2023.
//
// MARK: Fichier regroupant les fonctions permettant de retrouver l'id des records airtable nécessaire pour les call API PATCH

import Foundation


/// fonction permettant de retrouver l'id du record de l'activité concerné
func findActivityRecordID(activityID: Int, records: [ActivityRecord]) -> String {
    for record in records {
        if record.fields.id == activityID {
            return record.id
        }
    }
    return "nil" /// Retourne nil si aucun enregistrement correspondant n'est trouvé
}
/// fonction permettant de retrouver les ids du record d'un tableau d'activité
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
/// fonction permettant de retrouver l'id du record du user concerné
func findUserRecordID(userID: Int, records: [UserRecord]) -> String {
    for record in records {
        if record.fields.id == userID {
            return record.id
        }
    }
    return "nil" /// Retourne nil si aucun enregistrement correspondant n'est trouvé
}
