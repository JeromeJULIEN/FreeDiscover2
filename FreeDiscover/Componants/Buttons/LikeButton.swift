//
//  LikeButton.swift
//  FreeDiscover
//
//  Created by apprenant92 on 24/10/2023.
//

import SwiftUI

struct LikeButton : View {
    @State var isPressed = false
    var body: some View {
        ZStack {
            Image(systemName: "heart.fill")
                .opacity(isPressed ? 1 : 0)
                .scaleEffect(isPressed ? 1.0 : 0.1)
                .animation(.linear)
            
            Image(systemName: "heart")
        }.font(.system(size: 40))
            .onTapGesture {
                self.isPressed.toggle()
        }
        .foregroundColor(isPressed ? .red : .white)
    }
}
