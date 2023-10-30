//
//  laurelleadingLevel.swift
//  FreeDiscover
//
//  Created by apprenant70 on 26/10/2023.
//

import SwiftUI

struct laurelleadingLevel: View {
    var body: some View {
        Image(systemName: "laurel.leading")
            .imageScale(.small)
            .padding(10)
            .foregroundStyle(.black)
            .background(Color.accentColor, in: Circle())
            .shadow(color: Color.secondary, radius: 4)
    }
}

#Preview {
    laurelleadingLevel()
}
