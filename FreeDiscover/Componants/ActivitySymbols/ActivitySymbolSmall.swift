//
//  ActivitySymbol.swift
//  FreeDiscover
//
//  Created by jerome julien on 19/10/2023.
//

import SwiftUI

struct ActivitySymbolSmall: View {
    var activityType : ActivityTypes
    
    var body: some View {
        ZStack {
            switch activityType {
            case .nature:
                    Circle()
                        .frame(width:20)
                        .foregroundColor(.green)
                        .shadow(radius: 2)
                       
                    Image(systemName: "leaf.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 10))
            case .sport:
                    Circle()
                        .frame(width:20)
                        .foregroundColor(.orange)
                        .shadow(radius: 2)
                    Image(systemName: "figure.run")
                        .foregroundColor(.white)
                        .font(.system(size: 10))
            case .culture:
                    Circle()
                        .frame(width:20)
                        .foregroundColor(.blue)
                        .shadow(radius: 2)
                        
                    Image(systemName: "building.columns.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 10))
                default:
                Circle().foregroundColor(.black).frame(width:44)
            }
            
            
        }
    }
}

#Preview {
    ActivitySymbolSmall(activityType: ActivityTypes.nature)
}
