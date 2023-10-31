//
//  CancelSearchButton.swift
//  FreeDiscover
//
//  Created by jerome julien on 27/10/2023.
//

import SwiftUI

struct CancelSearchButton: View {
    @EnvironmentObject var globalVariables : SearchGlobalVariables
    
    var body: some View {
        Button {
            globalVariables.isSearchOngoing = false
            globalVariables.searchContent = ""
            globalVariables.isNatureSelectedForSearch = true
            globalVariables.isSportSelectedForSearch = true
            globalVariables.isCultureSelectedForSearch = true
            globalVariables.isSocialSelectedForSearch = true

        } label:{
            ZStack{
                Circle()
                    .frame(width: 45)
                    .foregroundColor(.white)
                    .shadow(radius: 4)
                    .opacity(0.9)
                Image(systemName:  "xmark")
                    .fontWeight(.bold)
                    .imageScale(.large)
                    .padding(10)
                    .foregroundStyle(.accent)
            }
        }
    }
}

#Preview {
    CancelSearchButton()
}
