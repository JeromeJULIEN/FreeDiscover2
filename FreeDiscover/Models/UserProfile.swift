//
//  UserProfile.swift
//  FreeDiscover
//
//  Created by apprenant58 on 20/10/2023.
//

import Foundation

struct UserProfile: Identifiable {
    var id = UUID()
    var userName: String
    var userPicture: String
    var userStatus: String
    var userContribution: Int
    var userPoints: Int
}
    
    var users = [
        UserProfile(userName: "Marion", userPicture: "marion", userStatus: "Serial Discoverer", userContribution: 13, userPoints: 0),
        UserProfile(userName: "Arthur", userPicture: "arthur", userStatus: "Baby Discoverer", userContribution: 1, userPoints: 0),
        UserProfile(userName: "Michaela", userPicture: "michaela", userStatus: "Maxi Discoverer", userContribution: 5, userPoints: 0)
    ]

