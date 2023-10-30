//
//  ThumbsupButton.swift
//  FreeDiscover
//
//  Created by apprenant70 on 26/10/2023.
//

import SwiftUI

struct ThumbsupButton: View {
    var body: some View {
        Image(systemName: "hand.thumbsup.fill")
            .imageScale(.small)
            .padding(10)
            .foregroundStyle(.white)
            .background(Color.accentColor, in: Circle())
            .shadow(color: Color.secondary, radius: 4)
    }
}
#Preview {
    ThumbsupButton()
}
