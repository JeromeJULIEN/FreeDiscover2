// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct UserRequest: Codable {
    let records: [UserRecord]
    let offset: String
}

// MARK: - Record
struct UserRecord: Codable {
    let id, createdTime: String
    let fields: User
}

// MARK: - Fields
struct User: Codable, Identifiable {
    let activities: [String]
    let id: Int
    let name: String
    let userPicture: [UserPicture]
    let favorite: [String]
}

// MARK: - UserPicture
struct UserPicture: Codable {
    let id: String
    let width, height: Int
    let url: String
    let filename: String
    let size: Int
    let type: String
    let thumbnails: Thumbnails
}

// MARK: - Thumbnails
struct Thumbnails: Codable {
    let small, large, full: Full
}

// MARK: - Full
struct Full: Codable {
    let url: String
    let width, height: Int
}
