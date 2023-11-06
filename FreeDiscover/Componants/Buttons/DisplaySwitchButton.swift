//
//  DisplaySwitchButton.swift
//  FreeDiscover
//
//  Created by jerome julien on 19/10/2023.
//

import SwiftUI

struct DisplaySwitchButton: View {
    @Binding var displayMode: ViewMode
    @Binding var showCarroussel : Bool
    @Binding var showActivityPreview : Bool

    var body : some View{
        ZStack{
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
            .frame(width: 130,height: 30)
            .shadow(radius: 4)
            .foregroundColor(.white)
            RoundedRectangle(cornerRadius: 25)
            .frame(width: 65, height: 26)
            .offset(x: displayMode == .map ? -30 : 30)
            .foregroundColor(.accentColor)
            HStack{
                Spacer()
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        displayMode = .map
                        showCarroussel = true
                    }}, label: {
                    Image(systemName: "map")
                    .foregroundColor(displayMode == .map ? .white : Color("GrayDark"))
                    .frame(width: 55)
                })
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        displayMode = .list
                        showCarroussel = false
                        showActivityPreview = false
                    }}, label: {
                    Image(systemName: "list.bullet")
                    .foregroundColor(displayMode == .list ? .white : Color("GrayDark"))
                    .frame(width: 55)
                })
                Spacer()

            }
        }
    }
}

#Preview {
    // besoin de passer avec .constant la valeur en binding pour générer la preview
    DisplaySwitchButton(displayMode: .constant(.map), showCarroussel: .constant(false), showActivityPreview: .constant(false))
}
