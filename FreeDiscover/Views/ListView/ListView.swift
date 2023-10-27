//
//  ListView.swift
//  FreeDiscover
//
//  Created by jerome julien on 19/10/2023.
//

import SwiftUI

struct ListView: View {
    /// Importation des variables globales
    @EnvironmentObject var globalVariables : GlobalVariables
    
    func searchActivities() {
        globalVariables.searchResults = FreeDiscover.allFreeDiscover.filter(searchText: globalVariables.searchContent)
    }
    
    var body: some View {
            VStack(spacing:15){
                Spacer().frame(height: 75)
                if(globalVariables.isSearchOngoing == false){
                    ForEach(FreeDiscover.allFreeDiscover){activity in
                        NavigationLink(destination:ActivityDetailView()){
                            ListCard(activity: activity)
                        }.accentColor(Color("GrayDark"))
                    }
                }
                if(globalVariables.isSearchOngoing == true){
                    ForEach(globalVariables.searchResults){activity in
                        NavigationLink(destination:ActivityDetailView()){
                            ListCard(activity: activity)
                        }.accentColor(Color("GrayDark"))
                    }
                    if(globalVariables.searchResults.count == 0){
                        ZStack{
                            RoundedRectangle(cornerRadius: 25)
                                .frame(width: 300,height: 50)
                                .foregroundColor(.accent)
                            Text("Aucune activitée trouvée...😭")
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                        
                    }
                }
                
            }
            .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                   alignment: (globalVariables.isSearchOngoing == true && globalVariables.searchResults.count == 0) ? .center : .top)
            .padding()
            .onChange(of:globalVariables.isSearchOngoing){
                searchActivities()
            }
    }
}
               

#Preview {
    ListView().environmentObject(GlobalVariables())
}
