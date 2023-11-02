// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation
import SwiftUI

// MARK: - Request
//changer le nom de la requête !
//1 requête = 1 type de donnée pull
struct ActivityRequest: Codable {
    let records: [ActivityRecord]
//    let offset: String
}

// MARK: - Record
//changer le nom de la requête !
//1 requête = 1 type de donnée pull
struct ActivityRecord: Codable {
    let id, createdTime: String
    let fields: Activity
}

// MARK: - Activity
// /!\ RIEN NE VOUS FORCE A METTRE CETTE STRUCT EN CLASS, C'EST FAIT A TITRE D'EXEMPLE
// /!\ VOUS POUVEZ POUVEZ OBSERVER UN SEUL UTILISATEUR SI BESOIN

//on observer les changement des variables mis en Published
//le ObservableObject indique qu'on va devenir des stalker
//le @Published est la victime ;D

//oubliez pas de rendre votre donnée finale (celle que vous voulez utiliser et travailler) Identifiable pour SwiftUI
class Activity: Codable, Identifiable, ObservableObject {
    let dateDeFin: String
    let id: Int
    //si vous utilisez des attachements sur Airtable toutes vos images vont venir de la même manière
    //donc on utilise un type global d'image, ici DataBaseImage que ce soit utiliser partout et éviter d'avoir 3-4 structures d'images différentes
    //alors que la donnée  reçu reste la même
    let photos: [ImageDataModel]
    let favoriteByUserID: [String]
    let famille: String
    let vote: Int
    let accessibilite: String
    let latitude, longitude: Double
    let description, typeActivite, temporaire, name: String
    let dateDeDebut: String
    let creator: String

    //ce truc là c'est pour nous aider a coder et decoder
    //ça communique les infos envoyer avec ce style pour se conformer au attentes de Airtable
    enum CodingKeys: String, CodingKey {
        case dateDeFin = "Date de fin"
        case id, photos
        case favoriteByUserID = "favoriteByUserId"
        case famille = "Famille"
        case vote
        case accessibilite = "Accessibilite"
        case latitude, longitude
        case description = "Description"
        case typeActivite = "Type activite"
        case temporaire, name
        case dateDeDebut = "Date de debut"
        case creator
    }
    
    //vue qu'on est maintenant dans une class on doit init (mettre prêt à l'emploi) les propriétés de class
    init(dateDeFin: String, id: Int, photos: [ImageDataModel], favoriteByUserID: [String], famille: String, vote: Int, accessibilite: String, latitude: Double, longitude: Double, description: String, typeActivite: String, temporaire: String, name: String, dateDeDebut: String, creator: String) {
        self.dateDeFin = dateDeFin
        self.id = id
        self.photos = photos
        self.favoriteByUserID = favoriteByUserID
        self.famille = famille
        self.vote = vote
        self.accessibilite = accessibilite
        self.latitude = latitude
        self.longitude = longitude
        self.description = description
        self.typeActivite = typeActivite
        self.temporaire = temporaire
        self.name = name
        self.dateDeDebut = dateDeDebut
        self.creator = creator
    }
    
    //ensuite on leur explique comment elles vont être décodées
    //en utilisant l'enum de CodingKeys on va lui dire quoi décoder
    //il faut comprendre à quoi correspondent ces CodingKeys, pour cela il faut le JSON de votre data
    //chacun de ces keys correspond a une propriété dans votre table Airtable
    //et on donne l'info au décoder.container
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        //ensuite on décode chaque propriété en fonction de sa CodingKey et de son type
        self.dateDeFin = try container.decode(String.self, forKey: .dateDeFin)
        self.id = try container.decode(Int.self, forKey: .id)
        self.photos = try container.decode([ImageDataModel].self, forKey: .photos)
        self.favoriteByUserID = try container.decode([String].self, forKey: .favoriteByUserID)
        self.famille = try container.decode(String.self, forKey: .famille)
        self.vote = try container.decode(Int.self, forKey: .vote)
        self.accessibilite = try container.decode(String.self, forKey: .accessibilite)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
        self.longitude = try container.decode(Double.self, forKey: .longitude)
        self.description = try container.decode(String.self, forKey: .description)
        self.typeActivite = try container.decode(String.self, forKey: .typeActivite)
        self.temporaire = try container.decode(String.self, forKey: .temporaire)
        self.name = try container.decode(String.self, forKey: .name)
        self.dateDeDebut = try container.decode(String.self, forKey: .dateDeDebut)
        self.creator = try container.decode(String.self, forKey: .creator)
    }
    
    //Le principle pour encoder est le même, on utilise les CodingKeys pour ciblé la bonne propriété
    //et on lui comment encoder
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(dateDeFin, forKey: .dateDeFin)
        try container.encode(id, forKey: .id)
        try container.encode(photos, forKey: .photos)
        try container.encode(favoriteByUserID, forKey: .favoriteByUserID)
        try container.encode(famille, forKey: .famille)
        try container.encode(vote, forKey: .vote)
        try container.encode(accessibilite, forKey: .accessibilite)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
        try container.encode(description, forKey: .description)
        try container.encode(typeActivite, forKey: .typeActivite)
        try container.encode(temporaire, forKey: .temporaire)
        try container.encode(name, forKey: .name)
        try container.encode(dateDeDebut, forKey: .dateDeDebut)
        try container.encode(creator, forKey: .creator)
    }
}


