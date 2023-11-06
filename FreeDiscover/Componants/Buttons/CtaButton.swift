//
//  CtaButton.swift
//  FreeDiscover
//
//  Created by apprenant92 on 20/10/2023.
//

import SwiftUI

struct CtaButton: View {
    var ctaText: String = ""
    var ctaIcon: String = ""
    var ctaBgColor: Color
    var ctaFgColor: Color
    
    var body: some View {
        @State var dates: Set<DateComponents> = []
        VStack {
            HStack {
                Image(systemName: ctaIcon)
                Text(ctaText)
            }
            .padding()
            .frame(minWidth: 360)
            .foregroundColor(ctaFgColor)
            .background(ctaBgColor)
            .cornerRadius(10)
        }
        

    }
}

#Preview {
    CtaButton(ctaText: "Sélectionner une date", ctaIcon: "calendar", ctaBgColor: Color.grayLight, ctaFgColor: Color.accentColor)
}
