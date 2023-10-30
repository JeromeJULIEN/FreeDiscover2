//
//  GamificationView.swift
//  FreeDiscover
//
//  Created by jerome julien on 19/10/2023.
//

import SwiftUI

struct GamificationView: View {
//    var level: LevelGame 
    var body: some View {
        
        VStack {
            Text("Partage tes bons plans et évalue les activités proposées. \n Gagne des points et fais évoluer ton profil!")
            ZStack{
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .frame(width: 330, height: 200)
                    .foregroundColor(.white)
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                VStack {
                    Text("Ton niveau actuel")
                    Image(systemName: "ant")
                        .resizable()
                        .frame(width: 30, height: 30)
                    Text("prout")
//                    barre de progression
                    Text("En route vers le niveau Prout avancé")
                    Text("Plus que xx contributions")
                }
            }
            ForEach(levels, id:\.self) { level in
                ExtractedView(level: level) }
        }
    }
}

#Preview {
    GamificationView()
}
//struct LevelGame: Identifiable, Hashable {
//    var id = UUID()
//    var levelNumber: Int
//    var levelName: String
//    var levelBadge: String
//    var nbOfContributionNeeded: Int
//}
// 
//var levels = [ 
//    LevelGame(levelNumber: 1, levelName: "Discover en herbe", levelBadge: "laurel.leading", nbOfContributionNeeded: 10),
//LevelGame(levelNumber: 2, levelName: "Discoverer avancé", levelBadge: "sparkles", nbOfContributionNeeded: 20),
//    LevelGame(levelNumber: 3, levelName: "Serial discoverer", levelBadge: "eye", nbOfContributionNeeded: 30),
//    LevelGame(levelNumber: 4, levelName: "Expert discoverer", levelBadge: "globe", nbOfContributionNeeded: 30)
//
//]

struct ExtractedView: View {
    var level: LevelGame
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.accentColor)
                Image(systemName: "\(level.levelBadge)")
                    .resizable()
                    .frame(width: 20, height: 25)
            }
            Text("Niveau \(level.levelNumber)") }
    }
}
