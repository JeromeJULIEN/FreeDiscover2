//
//  Profile rectangle.swift
//  FreeDiscover
//
//  Created by apprenant58 on 20/10/2023.
//

import SwiftUI

struct Profile_rectangle: View {
    var user : User
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 360, height: 160)
                .foregroundColor(.white)
                .shadow(radius: 8)
            
            
            HStack {
                if let imageFound = user.userPicture.first {
                    AsyncImage(url: URL(string: imageFound.url)) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFill()
                        } else if phase.error != nil {
                            Text("Image indisponible")
                        } else {
                            ProgressView()
                        }
                    }
                    .frame(width: 120,height: 120)
                   .clipShape(Circle())
//                   .padding()
                }
                VStack(alignment: .leading) {
                    Text("\(user.name)")
                        .foregroundColor(.accentColor)
                        .fontWeight(.bold)
                        .font(.largeTitle)
                    NavigationLink(destination: GamificationView(level: LevelGame(levelNumber: 1, levelName: "Discoverer en herbe", levelBadge: "Badge1", nbOfContributionNeeded: 10), userContribution: UserProfile.marion)) {
                        HStack {
                            Text("Discoverer en herbe")
                                .foregroundColor(.black)
                                Image("Badge1")
                                    .resizable()
                                    .foregroundColor(.black)
                                    .frame(width: 30, height: 30)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                    Text("\(user.activities.count) contributions")
                            
                            .foregroundColor(.gray)
                        .padding(.top, 4)
                     
                    NavigationLink(destination: CreateActivityView(currentCategory: .nature, isTemporary: true, currentUser: user, newLocation: NewLocation(id: UUID(), newLatitude: 0.0, newLongitude: 0.0))){
                        HStack {
                            Text("Ajouter une activité")
                                .foregroundColor(.gray)
                            Image(systemName:"plus.circle.fill")
                                .foregroundColor(.gray)
                                .fontWeight(.light)
                        }
                    }
                }
                .padding(.leading)
            }
        }
    }
}
#Preview {
    Profile_rectangle(user : User.marion)
}
