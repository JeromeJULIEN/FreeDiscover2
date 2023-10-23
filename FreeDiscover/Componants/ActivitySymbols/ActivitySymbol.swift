//
//  ActivitySymbol.swift
//  FreeDiscover
//
//  Created by jerome julien on 19/10/2023.
//

import SwiftUI

struct ActivitySymbol: View {
    var activityType : String
    var temporary : Bool
    
    var body: some View {
        ZStack {
            switch activityType {
                case "nature":
                    Circle()
                        .frame(width:36)
                        .foregroundColor(.green)
                        .shadow(radius: 2)
                        .overlay(Circle().stroke(temporary ? Color.white : Color.clear, lineWidth: 4)).shadow(radius: 2)
                    Image(systemName: "leaf.fill")
                        .foregroundColor(.white)
                        .imageScale(.large)
                case "sport":
                    Circle()
                        .frame(width:36)
                        .foregroundColor(.orange)
                        .shadow(radius: 2)
                        .overlay(Circle().stroke(temporary ? Color.white : Color.clear, lineWidth: 4)).shadow(radius: 2)
                    Image(systemName: "figure.run")
                        .foregroundColor(.white)
                        .imageScale(.large)
                case "culture":
                    Circle()
                        .frame(width:36)
                        .foregroundColor(.blue)
                        .shadow(radius: 2)
                        .overlay(Circle().stroke(temporary ? Color.white : Color.clear, lineWidth: 4)).shadow(radius: 2)
                    Image(systemName: "building.columns.fill")
                        .foregroundColor(.white)
                        .imageScale(.large)
                default:
                Circle().foregroundColor(.black).frame(width:36)
            }
            
            
        }
    }
}

#Preview {
    ActivitySymbol(activityType: "nature",temporary: true)
}
