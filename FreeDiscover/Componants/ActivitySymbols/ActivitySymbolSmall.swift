//
//  ActivitySymbol.swift
//  FreeDiscover
//
//  Created by jerome julien on 19/10/2023.
//

import SwiftUI

struct ActivitySymbolSmall: View {

//    var activityType : String

    var activityType : String
    

    var body: some View {
        ZStack {
            switch activityType {
            case "nature":
                    Circle()
                        .frame(width:20)
                        .foregroundColor(.natureGreen)
                        .shadow(radius: 2)
                       
                    Image(systemName: "leaf.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 10))
            case "sport":
                    Circle()
                        .frame(width:20)
                        .foregroundColor(.sportOrange)
                        .shadow(radius: 2)
                    Image(systemName: "figure.run")
                        .foregroundColor(.white)
                        .font(.system(size: 10))
            case "culture":
                    Circle()
                        .frame(width:20)
                        .foregroundColor(.cultureBlue)
                        .shadow(radius: 2)
                        
                    Image(systemName: "building.columns.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 10))
            case "social":
                    Circle()
                        .frame(width:20)
                        .foregroundColor(.socialRed)
                        .shadow(radius: 2)
                        
                    Image(systemName: "figure.socialdance")
                        .foregroundColor(.white)
                        .font(.system(size: 10))
            default:
                Circle().foregroundColor(.black).frame(width:44)
            }
            
            
        }
    }
}

#Preview {
    ActivitySymbolSmall(activityType: "nature")
}
