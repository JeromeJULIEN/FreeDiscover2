//
//  SearchSymbol.swift
//  FreeDiscover
//
//  Created by jerome julien on 19/10/2023.
//

/*
 Abstract:
 `SearchSymbol` ReprÃ©sente le symbol recherche qui est placer sur la carte pour l'ouverture de la barre de recherche.
 */

import SwiftUI

struct SearchButton: View {
    var body: some View {
        Image(systemName:  "magnifyingglass")
            .imageScale(.large)
            .padding(10)
            .foregroundStyle(.white)
            .background(Color.accentColor, in: Circle())
            .shadow(color: Color.secondary, radius: 4)
    }
}

#Preview {
    SearchButton()
}
