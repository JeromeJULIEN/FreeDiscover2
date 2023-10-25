//
//  SheetSearchView.swift
//  FreeDiscover
//
//  Created by apprenant 101 on 24/10/2023.
//

// MARK: - SearchViewSearch

/*
 `SheetViewShearch` Une vue qui affcihe la modalSheet rechercher.
 */

import SwiftUI

struct SheetViewShearch: View {
    
    ///
    @Environment (\.dismiss) var dismiss
    
    /// Propriété d'état pour contenir le texte de recherche qu'un utiliosateur tape dans le champ de recherche.
    @State private var searchFreeDiscover = ""
    
    /// Booleen de type édition pour éditer la recherche de l'utilisateur.
    @State private var isEditing: Bool = false
    
    /// Propriété d'état pour l'animation du bouton `Cancel`.
    @State private var animateButtonCancel: Double = 0.3
    
    
    var body: some View {
        
        /// 1) -  Search bar personnalisée est désactive la correction automatique pour cette vue.
        ZStack(alignment: .top) {
            HStack {
                TextField("Rechercher une activité.", text: $searchFreeDiscover)
                    .padding(10)
                    .padding(.horizontal, 25)
                    .background(Color.gray.opacity(0.2),
                                in: RoundedRectangle(
                                    cornerRadius: 8,
                                    style: .continuous))
                    
                /// 3) - Symbol search, ajout du symbol éffacer la recherche dans la searchBar.
                    .overlay (
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .imageScale(.small)
                                .foregroundStyle(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 8)
                            
                            if isEditing {
                                Button(action: {
                                    self.searchFreeDiscover = ""
                                }, label: {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundStyle(.gray)
                                        .padding(.trailing, 8)
                                })
                            }
                            
                        }
                    )
                    .padding(.horizontal, 10)
                    .autocorrectionDisabled()
                    .onTapGesture {
                        self.isEditing = true
                    }
                
                /// 2) - Bouton pour annuler la recherche éffectuer par l'utilisateur qui est animer.
                if isEditing {
                    Button(action: {
                        self.isEditing = false
                        self.searchFreeDiscover = ""
                    }, label: {
                        
                        Text("Cancel")
                    })
                    .padding(.trailing, 10)
                    .transition(.move(edge: .trailing))
                    .animation(.default, value: animateButtonCancel)
                    
                }
                
            }
//            .presentationDetents([.height(200), .large])
//            .presentationBackground(.secondary)
            .presentationCornerRadius(16)
            .presentationDragIndicator(.visible)
            .presentationBackgroundInteraction(.enabled(upThrough: .large))
            
        }

    }
}

#Preview {
    NavigationStack {
        SheetViewShearch()
    }
}
