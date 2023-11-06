//
//  ListView.swift
//  FreeDiscover
//
//  Created by jerome julien on 19/10/2023.
//

import SwiftUI

struct ListView: View {
    // MARK: Variable externes
    /// Importation des variables globales
    @EnvironmentObject var searchGlobalVariables : SearchGlobalVariables
    @EnvironmentObject var activityGlobalVariables : APIActivityRequestModel
    
    @State var showActivityPreview : Bool = false
    
    // MARK: Fonctions de la vue
    func searchActivities() {
        searchGlobalVariables.searchResults = activityGlobalVariables.allActivities.filter(searchText: searchGlobalVariables.searchContent,lookForNature: searchGlobalVariables.isNatureSelectedForSearch,lookForSport: searchGlobalVariables.isSportSelectedForSearch,lookForCulture: searchGlobalVariables.isCultureSelectedForSearch,lookForSocial: searchGlobalVariables.isSocialSelectedForSearch)
    }
    
    // MARK: Vue
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack(spacing:15){
                Spacer().frame(height: 75)
                if(searchGlobalVariables.isSearchOngoing == false){
                    ForEach(activityGlobalVariables.allActivities){activity in
                        NavigationLink(destination:ActivityDetailView(activity: activity)){
                            ListCard(activity: activity)
                        }.accentColor(Color("GrayDark"))
                    }
                }
                if(searchGlobalVariables.isSearchOngoing == true){
                    ForEach(searchGlobalVariables.searchResults){activity in
                        NavigationLink(destination:ActivityDetailView(activity: activity)){
                            ListCard(activity: activity)
                        }.accentColor(Color("GrayDark"))
                    }
                    if(searchGlobalVariables.searchResults.count == 0){
                        ZStack{
                            RoundedRectangle(cornerRadius: 25)
                                .frame(width: 300,height: 50)
                                .foregroundColor(.accent)
                            Text("Aucune activité trouvée...😭")
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                        
                    }
                }
                
            }
            .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                   alignment: (searchGlobalVariables.isSearchOngoing == true && searchGlobalVariables.searchResults.count == 0) ? .center : .top)
            .padding()
            .onChange(of:searchGlobalVariables.isSearchOngoing){
                searchActivities()
            }
        }
    }
}
               

#Preview {
    ListView().environmentObject(SearchGlobalVariables()).environmentObject(APIUserRequestModel())
        .environmentObject(APIActivityRequestModel())
}
