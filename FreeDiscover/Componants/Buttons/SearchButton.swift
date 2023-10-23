//
//  SearchButton.swift
//  FreeDiscover
//
//  Created by jerome julien on 19/10/2023.
//

import SwiftUI

struct SearchButton: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width:50)
                .foregroundColor(.accentColor)
                .shadow(radius: 4)
            Image(systemName: "magnifyingglass")
                .foregroundColor(.white)
                .font(.system(size: 24))
                .fontWeight(.semibold)
        }
    
    }
}

#Preview {
    SearchButton()
}
