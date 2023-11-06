//
//  LoadingScreen.swift
//  FreeDiscover
//
//  Created by jerome julien on 06/11/2023.
//

import SwiftUI

struct LoadingScreen: View {
    var body: some View {
        ZStack{
            Rectangle()
                .frame(width: .infinity,height: .infinity)
                .foregroundColor(.accent)
                .ignoresSafeArea()
            Text("Free Discover")
                .foregroundColor(.white)
                .font(.title)
                .fontWeight(.heavy)

        }
    }
}

#Preview {
    LoadingScreen()
}
