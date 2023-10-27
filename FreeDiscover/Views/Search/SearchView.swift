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
    // MARK: Variables locales
    ///
    @Environment (\.dismiss) var dismiss
    
    /// Booleen de type édition pour éditer la recherche de l'utilisateur.
    @State private var isEditing: Bool = false
        
    /// Propriété d'état pour l'animation du bouton `Cancel`.
    @State private var animateButtonCancel: Double = 0.3
    
    /// varaible d'état pour selection des catégories
    @State var isNatureSelected : Bool = true
    @State var isCultureSelected : Bool = true
    @State var isSportSelected : Bool = true
    
    // MARK: Variables héritées
    /// gestion de l'affichage de la vue de recherche
    @Binding var showSearchView : Bool
    
    /// variable pour lancer une recherche
    @EnvironmentObject var globalVariables : GlobalVariables

    
    
    
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
                TextField("Indiquez ce que vous recherchez", text: $globalVariables.searchContent)
                    .padding(10)
                    .padding(.horizontal, 25)
                    .background(Color.gray.opacity(0.2),
                                in: RoundedRectangle(
                                    cornerRadius: 8,
                                    style: .continuous))
                HStack(spacing:50){
                    SelectableActivitySymbol(activityType: ActivityTypes.nature, isSelected: $isNatureSelected)
                    SelectableActivitySymbol(activityType: ActivityTypes.sport, isSelected: $isSportSelected)
                    SelectableActivitySymbol(activityType: ActivityTypes.culture, isSelected: $isCultureSelected)
                }
                Button(action: {
                    globalVariables.launchSearch.toggle()
                    globalVariables.isSearchOngoing = true
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
        SearchView(showSearchView: .constant(true)).environmentObject(GlobalVariables())
    }
}
