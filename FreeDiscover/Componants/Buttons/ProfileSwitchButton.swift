//
//  ProfileSwitchButton.swift
//  FreeDiscover
//
//  Created by apprenant58 on 23/10/2023.
//

import SwiftUI

enum ProfileViewMode {
    case favorite, contribution
}

struct ProfileSwitchButton: View {
    @Binding var currentMode: ProfileViewMode


    var body : some View{
        ZStack{
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
            .frame(width: 340,height: 30)
            .shadow(radius: 4)
            .foregroundColor(.white)
            RoundedRectangle(cornerRadius: 25)
            .frame(width: 170, height: 26)
            .offset(x: currentMode == .favorite ? -82 : 82)
            .foregroundColor(.accentColor)
            HStack{
                Spacer()
                Button(action: {currentMode = .favorite}, label: {
                    Text("Mes lieux favoris")
                    .foregroundColor(currentMode == .favorite ? .white : Color("GrayDark"))
                    .frame(width: 170)
                })
                Button(action: {currentMode = .contribution}, label: {
                    Text("Mes contributions")
                    .foregroundColor(currentMode == .contribution ? .white : Color("GrayDark"))
                    .frame(width: 170)
                })
                Spacer()

            }
        }
        .animation(Animation.easeInOut(duration: 0.3), value: currentMode)
    }
}


#Preview {
    ProfileSwitchButton(currentMode: .constant(.favorite))
}
