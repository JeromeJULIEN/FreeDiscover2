//
//  GamificationView.swift
//  FreeDiscover
//
//  Created by jerome julien on 19/10/2023.
//

import SwiftUI

struct GamificationView: View {
    var level: LevelGame
    var userContribution: UserProfile
    var body: some View {
        
        VStack {
            Text("Partage tes bons plans et \n évalue les activités proposées. \n Gagne des points et fais évoluer ton profil!")
                .multilineTextAlignment(.center)
                .padding()
            
            ZStack{
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .frame(width: 350, height: 200)
                    .foregroundColor(.white)
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                VStack {
                    Text("Ton niveau actuel")
                        .font(.title2)
                    Image( "\(level.levelBadge)")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    Text("\(level.levelName)")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .font(.title)
                        
                    ProgressView(value: Double(7), total: Double(level.nbOfContributionNeeded))
                        .frame(width: 300)

                    Text("En route vers le niveau Discoverer avancé")
                        .font(.callout)
                        .foregroundColor(.grayDark)
                }
            }
            .padding()
            
            ScrollView() {
                ForEach(levels, id:\.self) { level in
                    ExtractedView(level: level, userContribution: UserProfile(id: 1)) }
            }
        }
    }
}

#Preview {
    GamificationView(level: LevelGame(levelNumber: 1, levelName: "Discoverer en herbe", levelBadge: "Badge1", nbOfContributionNeeded: 10), userContribution: UserProfile.marion)
}

struct ExtractedView: View {
    var level: LevelGame
    var userContribution: UserProfile
    var body: some View {
        HStack {
            ZStack {

                Image("\(level.levelBadge)")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding(12)
            VStack(alignment: .leading) {
                Text("Niveau \(level.levelNumber)")
                    .fontWeight(.bold)
                    .font(.title3)
                Text("\(level.levelName)")
            }
                Spacer()
            VStack {
                Text("6 /\(level.nbOfContributionNeeded)")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .font(.title2)
                Text("Contributions")
                    .font(.footnote)
            }                 
            .padding(.trailing)
            .navigationTitle("Mon niveau")

        }
    }
}
