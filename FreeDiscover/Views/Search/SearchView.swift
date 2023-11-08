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

struct SearchView : View {
    // MARK: Variables héritées
    /// gestion de l'affichage de la vue de recherche
    @Binding var showSearchView : Bool
    
    /// variable pour lancer une recherche
    @EnvironmentObject var searchGlobalVariables : SearchGlobalVariables
    
    
    // MARK: Variables locales
    /// Booleen de type édition pour éditer la recherche de l'utilisateur.
    @State private var isEditing: Bool = false
        
    /// Propriété d'état pour l'animation du bouton `Cancel`.
    @State private var animateButtonCancel: Double = 0.3
        
    
    // MARK: Vue
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(height: 330)
                .foregroundColor(.white)
                .shadow(radius: 4)
            VStack(spacing:20){
                HStack{
                    Spacer()
                    Text("Rechercher une activité").foregroundColor(.grayDark)
                    Spacer()
                    /// Boutton pour fermer la vue
                    Button(action: {
                        showSearchView.toggle()
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.accent)
                            .font(.title)
                    })
                }
                .padding(.top,30)
                Divider()
                /// On stocke le contenu du champ de saisie dans les variables globales `searchGlobalVariable`
                TextField("Indiquez ce que vous recherchez", text: $searchGlobalVariables.searchContent)
                    .padding(10)
                    .padding(.horizontal, 25)
                    .background(Color.gray.opacity(0.2),
                                in: RoundedRectangle(
                                    cornerRadius: 8,
                                    style: .continuous))
                HStack(spacing:50){
                    SelectableActivitySymbol(activityType: ActivityTypes.nature, isSelected: $searchGlobalVariables.isNatureSelectedForSearch)
                    SelectableActivitySymbol(activityType: ActivityTypes.sport, isSelected: $searchGlobalVariables.isSportSelectedForSearch)
                    SelectableActivitySymbol(activityType: ActivityTypes.culture, isSelected: $searchGlobalVariables.isCultureSelectedForSearch)
                    SelectableActivitySymbol(activityType: ActivityTypes.social, isSelected: $searchGlobalVariables.isSocialSelectedForSearch)
                    
                }
                /// Bouton pour lancer la recherche
                Button(action: {
                    searchGlobalVariables.launchSearch.toggle()
                    searchGlobalVariables.isSearchOngoing = true
                    showSearchView.toggle()
                }, label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .frame(height: 50)
                        Text("Rechercher")
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                    
                })
            }
            .padding()
            
        }
        .ignoresSafeArea()
        .offset(y: showSearchView ? 0 : -390)
        .animation(.easeInOut(duration: 0.3),value: showSearchView)
    }
}

#Preview {
    NavigationStack {
        SearchView(showSearchView: .constant(true)).environmentObject(SearchGlobalVariables())
    }
}
