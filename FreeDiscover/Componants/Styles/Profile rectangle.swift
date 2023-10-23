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
    var userStatus: String
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
                    .padding()
                VStack(alignment: .leading) {
                    Text(userName)
                        .foregroundColor(.accentColor)
                        .fontWeight(.bold)
                        .font(.title2)
                    
                    Text(userStatus)
                    Text("\(userContribution) contributions")
                        .fontWeight(.light)
                        .foregroundColor(.gray)
                    
                }
                .padding()
            }
        }
        .padding()
    }
}
#Preview {
    Profile_rectangle(userName: "Marion", userPicture: "marion", userStatus: "Serial Discoverer", userContribution: 0)
}
