//
//  GamificationView.swift
//  FreeDiscover
//
//  Created by jerome julien on 19/10/2023.
//

import SwiftUI

struct GamificationView: View {
    var level: LevelGame 
    var body: some View {
        
        VStack {
            Text("Partage tes bons plans et \n évalue les activités proposées. \n Gagne des points et fais évoluer ton profil!")
                .multilineTextAlignment(.center)
                .padding()
            
            ZStack{
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .frame(width: 330, height: 200)
                    .foregroundColor(.white)
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                VStack {
                    Text("Ton niveau actuel")
                        .font(.title2)
//                    Image(systemName: "ant")
//                        .resizable()
//                        .frame(width: 30, height: 30)
                    ZStack {
                        Circle()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.accentColor)
                        Image(systemName: "\(level.levelBadge)")
                            .resizable()
                            .frame(width: 20, height: 25)
                    }
                    Text("\(level.levelName)")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .font(.title)
                        
//                    ProgressView(value: level.nbOfContributionNeeded, total: 100)
//                    barre de progression
                    Text("En route vers le niveau Prout avancé")
                    Text("Plus que \(level.nbOfContributionNeeded)-5 contributions")
                }
            }
            .padding()
            ForEach(levels, id:\.self) { level in
                ExtractedView(level: level) }
        }
    }
}

#Preview {
    GamificationView(level: LevelGame(levelNumber: 1, levelName: "Discoverer en herbe", levelBadge: "laurel.leading", nbOfContributionNeeded: 0))
}

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
            VStack(alignment: .leading) {
                Text("Niveau \(level.levelNumber)")
                    .fontWeight(.bold)
                Text("\(level.levelName)")
            }
                Spacer()
            VStack {
                Text("8/\(level.nbOfContributionNeeded)")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .font(.title2)
                Text("Contributions")
                    .font(.footnote)
            }
        }
        .padding()
    }
}
