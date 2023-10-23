//
//  AccessibilitySymbol.swift
//  FreeDiscover
//
//  Created by apprenant92 on 20/10/2023.
//

import SwiftUI

struct AccessibilitySymbol: View {

    @State var symbolSelection: Int = 1
    @State private var isOn = false
    
    var accessSymbol: String
    var accessName: String
    var colorToShow: Color {
        switch symbolSelection {
        case 1:
            return .grayLight
        case 2:
            return .accentColor
        default:
            return .grayLight
        }
    }
    var body: some View {
            VStack {
                
                ZStack {
                    Circle()
                        .frame(width:44)
                        .foregroundColor(colorToShow)
                        .shadow(radius: 2)
                        .overlay(Circle().stroke(Color.clear, lineWidth: 4)).shadow(radius: 2)
                    
                    Image(systemName: accessSymbol)
                        .foregroundColor(.grayDark)
                        .imageScale(.large)
                }
                Text(accessName)
                    .font(.caption2)
                    .foregroundColor(.grayDark)
            }
            
        }
    }


#Preview {
    AccessibilitySymbol(accessSymbol: "figure.2.and.child.holdinghands", accessName: "Familiale")
}
