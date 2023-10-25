//
//  UserPositionSymbol.swift
//  FreeDiscover
//
//  Created by apprenant 101 on 24/10/2023.
//

// MARK: - UserPositionSymbol

/*
 Abstract:
 `UserPositionSymbol` Représente une vue personnalisé d'un point gps de l'utilisateur sur la carte.
 */

import SwiftUI

struct UserPositionSymbol: View {
    
    @State private var animatePositionUserLargeCircle = 1.5
    @State private var animatePositionUserMediumCircle = 1.0
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 32, height: 32)
                .foregroundStyle(.accent)
                .opacity(0.25)
            Circle()
                .frame(width: 20, height: 20)
                .foregroundStyle(.white)
            
            Circle()
                .frame(width: 12, height: 12)
                .foregroundStyle(.accent)
            
            
        }
        
        
//        .animation(.easeOut(duration: 1.0), value: animatePositionUser)
    }
}

#Preview {
    UserPositionSymbol()
}
