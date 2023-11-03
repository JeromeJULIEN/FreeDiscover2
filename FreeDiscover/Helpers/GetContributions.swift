//
//  GetContributions.swift
//  FreeDiscover
//
//  Created by apprenant58 on 02/11/2023.
//

import Foundation
func getContribution(userContributions : [Int],type : ActivityTypes)->[FreeDiscover]{
    var filteredArray = [FreeDiscover] ()
    filteredArray = FreeDiscover.allFreeDiscover.filter {activity in
        userContributions.contains(activity.id) && activity.type == type
    }
    return filteredArray
}
