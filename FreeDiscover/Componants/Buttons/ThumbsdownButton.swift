//
//  ThumbsdownButton.swift
//  FreeDiscover
//
//  Created by apprenant70 on 26/10/2023.
//

import SwiftUI

struct ThumbsdownButton: View {
    var body: some View {
        Image(systemName: "hand.thumbsdown.fill")
            .imageScale(.small)
            .padding(10)
            .foregroundStyle(.white)
            .background(.grayDark, in: Circle())
            .shadow(color: Color.secondary, radius: 4)
    }
}

#Preview {
    ThumbsdownButton()
}
