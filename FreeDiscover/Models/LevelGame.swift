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
    LevelGame(levelNumber: 1, levelName: "Discover en herbe", levelBadge: "Badge1", nbOfContributionNeeded: 5),
LevelGame(levelNumber: 2, levelName: "Discoverer avancé", levelBadge: "Badge2", nbOfContributionNeeded: 10),
    LevelGame(levelNumber: 3, levelName: "Serial discoverer", levelBadge: "Badge3", nbOfContributionNeeded: 20),
    LevelGame(levelNumber: 4, levelName: "Expert discoverer", levelBadge: "Badge4", nbOfContributionNeeded: 30)

]
