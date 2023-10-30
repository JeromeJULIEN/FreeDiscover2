//
//  ShareButton.swift
//  FreeDiscover
//
//  Created by apprenant70 on 26/10/2023.
//

import SwiftUI

struct ShareButton: View {
    var body: some View {
        Image(systemName: "square.and.arrow.up")
            .imageScale(.large)
            .padding(10)
            .foregroundStyle(.white)
            .background(Color.accentColor, in: Circle())
            .shadow(color: Color.secondary, radius: 4)
    }
}

#Preview {
    ShareButton()
}
