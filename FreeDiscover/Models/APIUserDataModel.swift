// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

// MARK: Modèle de donnée airtable pour la table User
/// Attention, airtable encapsule les `User` dans un `UserRecord`. L'objet de la table est dans le `User` mais le `UserRecord` va être nécessaire pour les fonctions `PATCH`

import Foundation

// MARK: - Request
//changer le nom de la requête !
//1 requête = 1 type de donnée pull
struct UserRequest: Codable {
    let records: [UserRecord]
    //let offset: String
}

// MARK: - Record
//changer le nom de la requête !
//1 requête = 1 type de donnée pull
struct UserRecord: Codable {
    let id, createdTime: String
    let fields: User
}

// MARK: - User
// /!\ RIEN NE VOUS FORCE A METTRE CETTE STRUCT EN CLASS, C'EST FAIT A TITRE D'EXEMPLE
// /!\ VOUS POUVEZ POUVEZ OBSERVER UN SEUL UTILISATEUR SI BESOIN

//on observer les changement des variables mis en Published
//le ObservableObject indique qu'on va devenir des stalker
//le @Published est la victime ;D

//oubliez pas de rendre votre donnée finale (celle que vous voulez utiliser et travailler) Identifiable pour SwiftUI
class User: Codable,Identifiable,ObservableObject, Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.favorite == rhs.favorite
    }
    
    @Published var activities : [String]
    @Published var userUpVote: [String]
    @Published var id: Int
    @Published var name: String
    @Published var userPicture: [ImageDataModel]
    @Published var favorite: [String]
    @Published var idFromFavorite: [Int]
    @Published var idFromActivities: [Int]
    @Published var idFromUserUpVote: [Int]
    @Published var userDownVote: [String]
    @Published var idFromUserDownVote: [Int]

    enum CodingKeys: String, CodingKey {
        case activities, userUpVote, id, name, userPicture, favorite
        case idFromFavorite = "id (from favorite)"
        case idFromActivities = "id (from activities)"
        case idFromUserUpVote = "id (from userUpVote)"
        case userDownVote
        case idFromUserDownVote = "id (from userDownVote)"
    }
    
    init(activities: [String], userUpVote: [String], id: Int, name: String, userPicture: [ImageDataModel], favorite: [String], idFromFavorite: [Int], idFromActivities: [Int], idFromUserUpVote: [Int], userDownVote: [String], idFromUserDownVote: [Int]) {
        self.activities = activities
        self.userUpVote = userUpVote
        self.id = id
        self.name = name
        self.userPicture = userPicture
        self.favorite = favorite
        self.idFromFavorite = idFromFavorite
        self.idFromActivities = idFromActivities
        self.idFromUserUpVote = idFromUserUpVote
        self.userDownVote = userDownVote
        self.idFromUserDownVote = idFromUserDownVote
    }
    
    //ensuite on leur explique comment elles vont être décodées
    //en utilisant l'enum de CodingKeys on va lui dire quoi décoder
    //il faut comprendre à quoi correspondent ces CodingKeys, pour cela il faut le JSON de votre data
    //chacun de ces keys correspond a une propriété dans votre table Airtable
    //et on donne l'info au décoder.container
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        //ensuite on décode chaque propriété en fonction de sa CodingKey et de son type
        self.activities = try container.decode([String].self, forKey: .activities)
        self.userUpVote = try container.decode([String].self, forKey: .userUpVote)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.userPicture = try container.decode([ImageDataModel].self, forKey: .userPicture)
        self.favorite = try container.decode([String].self, forKey: .favorite)
        self.idFromFavorite = try container.decode([Int].self, forKey: .idFromFavorite)
        self.idFromActivities = try container.decode([Int].self, forKey: .idFromActivities)
        self.idFromUserUpVote = try container.decode([Int].self, forKey: .idFromUserUpVote)
        self.userDownVote = try container.decode([String].self, forKey: .userDownVote)
        self.idFromUserDownVote = try container.decode([Int].self, forKey: .idFromUserDownVote)
    }
    
    //Le principle pour encoder est le même, on utilise les CodingKeys pour ciblé la bonne propriété
    //et on lui comment encoder
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(activities, forKey: .activities)
        try container.encode(userUpVote, forKey: .userUpVote)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(userPicture, forKey: .userPicture)
        try container.encode(favorite, forKey: .favorite)
        try container.encode(idFromFavorite, forKey: .idFromFavorite)
        try container.encode(idFromActivities, forKey: .idFromActivities)
        try container.encode(idFromUserUpVote, forKey: .idFromUserUpVote)
        try container.encode(userDownVote, forKey: .userDownVote)
        try container.encode(idFromUserDownVote, forKey: .idFromUserDownVote)
    }
}

extension User {
    static let marion = User(activities: ["1","2","5","10","15"], userUpVote: ["1","2","3"], id: 1, name: "Marion", userPicture: [ImageDataModel(id: "1", width: 1000, height: 1000, url: "", filename: "marion", size: 2800, type: "image.jpeg", thumbnails: Thumbnails(small: .init(url: "", width: 0, height: 0), large: .init(url: "", width: 0, height: 0), full: .init(url: "", width: 1000, height: 1000)))], favorite: ["1","2","5","9","14","3","4"], idFromFavorite: [1,2,5,9,14,3,4], idFromActivities: [1,2,5,10,15], idFromUserUpVote: [1,2,3], userDownVote: ["12","13"], idFromUserDownVote: [12,13])
}


