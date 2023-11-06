//
//  AccessibilitySymbol.swift
//  FreeDiscover
//
//  Created by apprenant92 on 20/10/2023.
//

import SwiftUI

struct AccessibilitySymbol: View {

    @Binding var isOn : Bool
        
        var accessSymbol: String
        var accessName: String

        var body: some View {
                VStack {
                    
                    ZStack {
                        Circle()
                            .frame(width:44)
                            .foregroundColor(isOn ? .accentColor : .grayLight)
                        
                            .shadow(radius: 2)
                            .overlay(Circle().stroke(Color.clear, lineWidth: 4)).shadow(radius: 2)
                        
                        Image(systemName: accessSymbol)
                            .foregroundColor(.grayDark)
                            .imageScale(.large)
                    }
                    .onTapGesture {
                        self.isOn.toggle()
                }
                    Text(accessName)
                        .font(.caption2)
                        .foregroundColor(.grayDark)
                }
                
            }
        }


    #Preview {
        AccessibilitySymbol(isOn: .constant(true), accessSymbol: "figure.2.and.child.holdinghands", accessName: "Familiale")
    }
