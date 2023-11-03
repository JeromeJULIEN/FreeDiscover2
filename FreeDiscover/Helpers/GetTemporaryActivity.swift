//
//  GetTemporaryActivity.swift
//  FreeDiscover
//
//  Created by jerome julien on 23/10/2023.
//

import Foundation

//@dev : function to filter all the temporary Activities of the data base
func getTemporaryActivities(activityList : [Activity]) -> [Activity] {
    return activityList.filter {
        $0.temporaire == "true"
    }
}
