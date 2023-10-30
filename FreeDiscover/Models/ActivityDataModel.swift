//// This file was generated from JSON Schema using quicktype, do not modify it directly.
//// To parse the JSON, add this file to your project and do:
////
////   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)
//
//import Foundation
//
//// MARK: - Welcome
//struct ActivityRequest: Codable {
//    let records: [ActivityRecord]
//    let offset: String
//}
//
//// MARK: - Record
//struct ActivityRecord: Codable {
//    let id, createdTime: String
//    let fields: Activity
//}
//
//// MARK: - Fields
//struct Activity: Codable, Identifiable {
//    let dateDeFin: String
//    let id: Int
//    let photos: [Photo]
//    let users: [String]
//    let famille: String
//    let vote: Int
//    let accessibilité: String
//    let latitude, longitude: Double
//    let description, typeDActivité, temporaire, name: String
//    let dateDeDébut: String
//    let userID: [String]
//
//    enum CodingKeys: String, CodingKey {
//        case dateDeFin = "Date de fin"
//        case id, photos
//        case users = "Users"
//        case famille = "Famille"
//        case vote
//        case accessibilité = "Accessibilité"
//        case latitude, longitude
//        case description = "Description"
//        case typeDActivité = "Type d'activité"
//        case temporaire, name
//        case dateDeDébut = "Date de début"
//        case userID = "userId"
//    }
//}
//
//// MARK: - Photo
//struct Photo: Codable {
//    let id: String
//    let width, height: Int
//    let url: String
//    let filename: String
//    let size: Int
//    let type: String
//    let thumbnails: Thumbnails
//}
//
//// MARK: - Thumbnails
//struct Thumbnails: Codable {
//    let small, large, full: Full
//}
//
//// MARK: - Full
//struct Full: Codable {
//    let url: String
//    let width, height: Int
//}
