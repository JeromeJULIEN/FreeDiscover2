//
//  GetActivityByType.swift
//  FreeDiscover
//
//  Created by jerome julien on 23/10/2023.
//

import Foundation

//@dev : function to filter the Activity of the data base in function of the activity type
func getActivityByType(type : ActivityTypes) -> [FreeDiscover] {
    return FreeDiscover.allFreeDiscover.filter {
        $0.type == type
    }
}
