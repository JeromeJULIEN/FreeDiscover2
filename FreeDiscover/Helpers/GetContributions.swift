//
//  GetContributions.swift
//  FreeDiscover
//
//  Created by apprenant58 on 02/11/2023.
//

import Foundation
//func getContribution(userContributions : [Int],type : ActivityTypes)->[FreeDiscover]{
//    var filteredArray = [FreeDiscover] ()
//    filteredArray = FreeDiscover.allFreeDiscover.filter {activity in
//        userContributions.contains(activity.id) && activity.type == type
//    }
//    return filteredArray
//}

func getContributionFromUserByType(activityDataBase: [Activity], userContribution : [Int],type : String)->[Activity]{
    var filteredArray = [Activity] ()
    filteredArray = activityDataBase.filter {activity in
        userContribution.contains(activity.id) && activity.typeActivite == type
    }
    return filteredArray
}

