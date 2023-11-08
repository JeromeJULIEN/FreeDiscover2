//
//  FindHighestID.swift
//  FreeDiscover
//
//  Created by apprenant92 on 06/11/2023.
//

import Foundation

/// fonction pour trouver l'id le plus haut du tableau activité afin de créer la nouvelle activité avec un ID incrémenté
func findHighestID(activities: [Activity]) -> Int {
        guard let maxId = activities.max(by: { $0.id < $1.id })?.id else {return 0}
        return maxId
    }
