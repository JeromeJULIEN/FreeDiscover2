//
//  CategoryPicker.swift
//  FreeDiscover
//
//  Created by apprenant92 on 24/10/2023.
//

import SwiftUI

struct CategoryPicker: View {
    @State var activityCategory: activityTypes
    
    var body: some View {
        
        ZStack{
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 346,height: 44)
                .shadow(radius: 4)
                .foregroundColor(.white)
                // RoundedRectangle(cornerRadius: 25)
            //    .frame(width: 60, height: 36)
            //    .offset(x: activityCategory == .nature ? -102 : 102)
             //   .foregroundColor(Color.accentColor)
            HStack{
                
                Button(action: {activityCategory = .nature}, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 80, height: 40)
                            .foregroundColor(activityCategory == .nature ? .natureGreen : Color.clear)
                        VStack {
                            Image(systemName: "leaf")
                                .foregroundColor(activityCategory == .nature ? .white : Color.grayDark)
                            Text("Nature")
                                .font(.footnote)
                                .bold()
                                .foregroundColor(activityCategory == .nature ? .white : Color.grayDark)
                                .frame(width: 80)
                            
                        }
                    }
        
                })
                Button(action: {activityCategory = .culture}, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 80, height: 40)
                            .foregroundColor(activityCategory == .culture ? .cultureBlue : Color.clear)
                        VStack {
                            Image(systemName: "building.columns")
                                .foregroundColor(activityCategory == .culture ? .white : Color.grayDark)
                            Text("Culture")
                                .font(.footnote)
                                .bold()
                                .foregroundColor(activityCategory == .culture ? .white : Color.grayDark)
                                .frame(width: 80)
                            
                        }
                    }
        
                })
                Button(action: {activityCategory = .sport}, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 80, height: 40)
                            .foregroundColor(activityCategory == .sport ? .sportOrange : Color.clear)
                        VStack {
                            Image(systemName: "figure.walk")
                                .foregroundColor(activityCategory == .sport ? .white : Color.grayDark)
                            Text("Sport")
                                .font(.footnote)
                                .bold()
                                .foregroundColor(activityCategory == .sport ? .white : Color.grayDark)
                                .frame(width: 80)
                            
                        }
                    }
        
                })
                Button(action: {activityCategory = .social}, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 80, height: 40)
                            .foregroundColor(activityCategory == .social ? .socialRed : Color.clear)
                        VStack {
                            Image(systemName: "figure.socialdance")
                                .foregroundColor(activityCategory == .social ? .white : Color.grayDark)
                            Text("Social")
                                .font(.footnote)
                                .bold()
                                .foregroundColor(activityCategory == .social ? .white : Color.grayDark)
                                .frame(width: 80)
                            
                        }
                    }
        
                })
                
             
                
            }
        }
    }
}

#Preview {
    CategoryPicker(activityCategory: .nature)
}
