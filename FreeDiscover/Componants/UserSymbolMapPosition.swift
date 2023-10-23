//
//  UserSymbolMapPosition.swift
//  FreeDiscover
//
//  Created by apprenant 101 on 23/10/2023.
//

/*
 Abstract:
 `UserPositionSymbol` Représente une vue personnalisé d'un point gps de l'utilisateur sur la carte et qui s'anime.
 */

import SwiftUI

struct UserSymbolMapPosition: View {
    
    /// Propriété d'état qui stocke l'animation du symbol de la position de l'utilisateur.
    @State private var animateSymbolPositiionUser = 2.0
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 32, height: 32)
                .foregroundStyle(.accent.opacity(0.25))
            Circle()
                .frame(width: 20, height: 20)
                .foregroundStyle(.white)
            Circle()
                .frame(width: 12, height: 12)
                .foregroundStyle(.accent)
        }
        .animation(.easeOut(duration: 1.0), value: animateSymbolPositiionUser)
        /// Todo: Travailler sur l'animation des que map inteégrer
    }
}

#Preview {
    UserSymbolMapPosition()
}
