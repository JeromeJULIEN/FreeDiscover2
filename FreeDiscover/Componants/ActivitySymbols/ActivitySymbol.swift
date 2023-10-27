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
                ZStack{
                    Circle()
                        .frame(width:36)
                        .foregroundColor(.green)
                        .shadow(radius: 2)
                    Image(systemName: "leaf.fill")
                        .foregroundColor(.white)
                        .imageScale(.large)
                    ZStack{
                        Rectangle()
                            .frame(width: 15,height: 12)
                            .foregroundColor(.white)
                        Image(systemName: "calendar")
                    }
                    .offset(x:15 , y:-15)
                    .opacity(temporary ? 1 : 0)
                    
                }
                case "sport":
                ZStack{
                    Circle()
                        .frame(width:36)
                        .foregroundColor(.orange)
                        .shadow(radius: 2)
                    Image(systemName: "figure.run")
                        .foregroundColor(.white)
                        .imageScale(.large)
                    ZStack{
                        Rectangle()
                            .frame(width: 15,height: 12)
                            .foregroundColor(.white)
                        Image(systemName: "calendar")
                    }
                    .offset(x:15 , y:-15)
                    .opacity(temporary ? 1 : 0)
                }
                case "culture":
                ZStack{
                    Circle()
                        .frame(width:36)
                        .foregroundColor(.blue)
                        .shadow(radius: 2)
                    Image(systemName: "building.columns.fill")
                        .foregroundColor(.white)
                        .imageScale(.large)
                    ZStack{
                        Rectangle()
                            .frame(width: 15,height: 12)
                            .foregroundColor(.white)
                        Image(systemName: "calendar")
                    }
                    .offset(x:15 , y:-15)
                    .opacity(temporary ? 1 : 0)
                }
                default:
                Circle().foregroundColor(.black).frame(width:36)
            }
            
            
        }
    }
}

#Preview {
    ActivitySymbol(activityType: "nature",temporary: true)
}
