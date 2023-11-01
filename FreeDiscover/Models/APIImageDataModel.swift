//
//  APIImageDataModel.swift
//  FreeDiscover
//
//  Created by jerome julien on 01/11/2023.
//

import Foundation

// MARK: - Photo
struct ImageDataModel : Codable {
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
