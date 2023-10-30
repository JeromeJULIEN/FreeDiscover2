//
//  LevelGame.swift
//  FreeDiscover
//
//  Created by apprenant58 on 30/10/2023.
//

import Foundation
import SwiftUI

struct LevelGame: Identifiable, Hashable {
    var id = UUID()
    var levelNumber: Int
    var levelName: String
    var levelBadge: String
    var nbOfContributionNeeded: Int
}
 
var levels = [
    LevelGame(levelNumber: 1, levelName: "Discover en herbe", levelBadge: "laurel.leading", nbOfContributionNeeded: 10),
LevelGame(levelNumber: 2, levelName: "Discoverer avancé", levelBadge: "sparkles", nbOfContributionNeeded: 20),
    LevelGame(levelNumber: 3, levelName: "Serial discoverer", levelBadge: "eye", nbOfContributionNeeded: 30),
    LevelGame(levelNumber: 4, levelName: "Expert discoverer", levelBadge: "globe", nbOfContributionNeeded: 30)

]
