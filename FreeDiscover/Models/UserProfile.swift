//
//  UserProfile.swift
//  FreeDiscover
//
//  Created by apprenant58 on 20/10/2023.
//

import Foundation

struct UserProfile: Identifiable {
    var id : Int
    var userName: String
    var userPicture: String
    var userContributions: [Int]
    var userFavorites : [Int]
    var userUpVote : [Int]
    var userDownVote : [Int]
    
    init(id: Int, userName: String = "", userPicture: String = "", userContributions: [Int] = [], userFavorites: [Int] = [], userUpVote: [Int] = [], userDownVote: [Int] = []) {
        self.id = id
        self.userName = userName
        self.userPicture = userPicture
        self.userContributions = userContributions
        self.userFavorites = userFavorites
        self.userUpVote = userUpVote
        self.userDownVote = userDownVote
    }
}

extension UserProfile {
    static let marion = UserProfile(id: 1,userName: "Marion", userPicture: "marion",userContributions: [1,2],userFavorites: [1,2],userUpVote: [4,5,13,12],userDownVote: [2])
    
    static let amine = UserProfile(id:2,userName: "Amine", userPicture: "amine",userContributions: [3],userFavorites: [3],userUpVote: [1,2],userDownVote: [3])
    
    static let arthur = UserProfile(id:3,userName: "Arthur", userPicture: "arthur", userContributions: [4],userFavorites: [1,3],userUpVote: [1,3],userDownVote: [5])
    
    static let ben =  UserProfile(id:4,userName: "Ben", userPicture: "ben", userContributions: [5],userFavorites: [1,5],userUpVote: [1,5],userDownVote: [2])
    
    static let users = [marion,amine,arthur,ben]
}

    
//    var users = [
//        UserProfile(id: 1,userName: "Marion", userPicture: "marion",userContributions: [1,2],userFavorites: [1,2],userUpVote: [4,5,13,12],userDownVote: [2]),
//        UserProfile(id:2,userName: "Amine", userPicture: "amine",userContributions: [3],userFavorites: [3],userUpVote: [1,2],userDownVote: [3]),
//        UserProfile(id:3,userName: "Arthur", userPicture: "arthur", userContributions: [4],userFavorites: [1,3],userUpVote: [1,3],userDownVote: [5]),
//        UserProfile(id:4,userName: "Ben", userPicture: "ben", userContributions: [5],userFavorites: [1,5],userUpVote: [1,5],userDownVote: [2])
//    ]

