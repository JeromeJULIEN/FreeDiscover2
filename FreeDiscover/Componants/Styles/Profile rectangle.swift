//
//  Profile rectangle.swift
//  FreeDiscover
//
//  Created by apprenant58 on 20/10/2023.
//

import SwiftUI

struct Profile_rectangle: View {
    var userName: String
    var userPicture: String
    var userContribution: Int
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 360, height: 160)
                .foregroundColor(.white)
                .shadow(radius: 8)
            
            
            HStack {
                Image(userPicture)
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray)
                VStack(alignment: .leading) {
                    Text(userName)
                        .foregroundColor(.accentColor)
                        .fontWeight(.bold)
                        .font(.largeTitle)
                    NavigationLink(destination: GamificationView(level: LevelGame(levelNumber: 1, levelName: "Discoverer en herbe", levelBadge: "laurel.leading", nbOfContributionNeeded: 10), userContribution: UserProfile.marion)) {
                        HStack {
                            Text("Discoverer en herbe")
                                .foregroundColor(.black)
                            ZStack {
                                Circle()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(.blueFD)
                                Image(systemName: "laurel.leading")
                                    .resizable()
                                    .foregroundColor(.black)
                                    .frame(width: 15, height: 15)
                            }
                        }
                    }
                        Text("\(userContribution) contributions")
                            
                            .foregroundColor(.gray)
                        .padding(.top, 10)
                     
                    NavigationLink(destination: CreateActivityView(currentCategory: .nature, isTemporary: true)){
                        HStack {
                            Text("Ajouter une activité")
                                .foregroundColor(.gray)
                            Image(systemName:"plus.circle.fill")
                                .foregroundColor(.gray)
                                .fontWeight(.light)
                            
                        }
                    }
//                    ZStack {
//                        RoundedRectangle(cornerRadius: 10)
//                            .frame(width: 160, height: 44)
//                            .foregroundColor(.grayLight)
//                        Text("Ajouter une contribution")
//                            .fontWeight(.bold)
//                            .foregroundColor(.accentColor)
//                    }
                }
                .padding()
            }
        }
    }
}
#Preview {
    Profile_rectangle(userName: "Marion", userPicture: "marion", userContribution: 0)
}
