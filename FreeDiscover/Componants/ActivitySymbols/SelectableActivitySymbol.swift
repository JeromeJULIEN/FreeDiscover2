//
//  SelectableActivitySymbol.swift
//  FreeDiscover
//
//  Created by jerome julien on 26/10/2023.
//

import SwiftUI

struct SelectableActivitySymbol: View {
    var activityType : ActivityTypes
    @Binding var isSelected : Bool
    
    var body: some View {
        ZStack {
            switch activityType {
            case .nature:
                Button(action: {
                    isSelected.toggle()
                }, label: {
                    VStack {
                        ZStack{
                            Circle()
                                .frame(width:40)
                                .foregroundColor(isSelected ? .natureGreen : .gray)
                                .shadow(radius: 2)
                            Image(systemName: "leaf.fill")
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                        Text("\(activityType.rawValue)")
                            .font(.caption)
                            .foregroundColor(.grayDark)
                    }
                })
            case .sport:
                Button(action: {
                    isSelected.toggle()
                }, label: {
                    VStack {
                        ZStack{
                            Circle()
                                .frame(width:40)
                                .foregroundColor(isSelected ? .sportOrange : .gray)
                                .shadow(radius: 2)
                            Image(systemName: "figure.run")
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                        Text("\(activityType.rawValue)")
                            .font(.caption)
                            .foregroundColor(.grayDark)
                    }
                })
            case .culture:
                Button(action: {
                    isSelected.toggle()
                }, label: {
                    VStack {
                        ZStack{
                            Circle()
                                .frame(width:40)
                                .foregroundColor(isSelected ? .cultureBlue : .gray)
                                .shadow(radius: 2)
                            Image(systemName: "building.columns.fill")
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                        Text("\(activityType.rawValue)")
                            .font(.caption)
                            .foregroundColor(.grayDark)
                    }
                })
            case .social:
                Button(action: {
                    isSelected.toggle()
                }, label: {
                    VStack {
                        ZStack{
                            Circle()
                                .frame(width:40)
                                .foregroundColor(isSelected ? .socialRed : .gray)
                                .shadow(radius: 2)
                            Image(systemName: "figure.socialdance")
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                        Text("\(activityType.rawValue)")
                            .font(.caption)
                            .foregroundColor(.grayDark)
                    }
                })
            default:
                Circle().foregroundColor(.black).frame(width:44)
            }
            
            
        }
    }
}

#Preview {
    SelectableActivitySymbol(activityType: ActivityTypes.nature, isSelected: .constant(false))
}
