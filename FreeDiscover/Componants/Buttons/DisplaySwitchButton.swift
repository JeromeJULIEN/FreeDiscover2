//
//  DisplaySwitchButton.swift
//  FreeDiscover
//
//  Created by jerome julien on 19/10/2023.
//

import SwiftUI

enum ViewMode {
    case map, list
}

struct DisplaySwitchButton: View {
    @State private var currentMode: ViewMode = .map


    var body : some View{
        ZStack{
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
            .frame(width: 130,height: 30)
            .shadow(radius: 4)
            .foregroundColor(.white)
            RoundedRectangle(cornerRadius: 25)
            .frame(width: 65, height: 26)
            .offset(x: currentMode == .map ? -30 : 30)
            .foregroundColor(.accentColor)
            HStack{
                Spacer()
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        currentMode = .map
                    }}, label: {
                    Image(systemName: "map")
                    .foregroundColor(currentMode == .map ? .white : Color("GrayDark"))
                    .frame(width: 55)
                })
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        currentMode = .list
                    }}, label: {
                    Image(systemName: "list.bullet")
                    .foregroundColor(currentMode == .list ? .white : Color("GrayDark"))
                    .frame(width: 55)
                })
                Spacer()

            }
        }
    }
}

#Preview {
    DisplaySwitchButton()
}
