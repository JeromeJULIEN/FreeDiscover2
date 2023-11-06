//
//  CategoryPicker.swift
//  FreeDiscover
//
//  Created by apprenant92 on 24/10/2023.
//

import SwiftUI

struct CategoryPicker: View {

    @Binding var currentCategory: ActivityTypes
    @State var buttonColor = Color.natureGreen
    @State var selectedCategory: String = "Category1"
    
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
                
                Button(action: {currentCategory = .nature;
                    buttonColor = .natureGreen}, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 80, height: 40)
                            .foregroundColor(currentCategory == .nature ? .natureGreen : Color.clear)
                        VStack {
                            Image(systemName: "leaf")
                                .foregroundColor(currentCategory == .nature ? .white : Color.grayDark)
                            Text("Nature").tag("Category1")
                                .font(.footnote)
                                .bold()
                                .foregroundColor(currentCategory == .nature ? .white : Color.grayDark)
                                .frame(width: 80)
                            
                        }
                    }
        
                })
                Button(action: {currentCategory = .culture;
                    buttonColor = .cultureBlue}, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 80, height: 40)
                            .foregroundColor(currentCategory == .culture ? .cultureBlue : Color.clear)
                        VStack {
                            Image(systemName: "building.columns")
                                .foregroundColor(currentCategory == .culture ? .white : Color.grayDark)
                            Text("Culture").tag("Category2")
                                .font(.footnote)
                                .bold()
                                .foregroundColor(currentCategory == .culture ? .white : Color.grayDark)
                                .frame(width: 80)
                            
                        }
                    }
        
                })
                Button(action: {currentCategory = .sport}, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 80, height: 40)
                            .foregroundColor(currentCategory == .sport ? .sportOrange : Color.clear)
                        VStack {
                            Image(systemName: "figure.walk")
                                .foregroundColor(currentCategory == .sport ? .white : Color.grayDark)
                            Text("Sport").tag("Category3")
                                .font(.footnote)
                                .bold()
                                .foregroundColor(currentCategory == .sport ? .white : Color.grayDark)
                                .frame(width: 80)
                            
                        }
                    }
        
                })
                Button(action: {currentCategory = .social}, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 80, height: 40)
                            .foregroundColor(currentCategory == .social ? .socialRed : Color.clear)
                        VStack {
                            Image(systemName: "figure.socialdance")
                                .foregroundColor(currentCategory == .social ? .white : Color.grayDark)
                            Text("Social").tag("Category4")
                                .font(.footnote)
                                .bold()
                                .foregroundColor(currentCategory == .social ? .white : Color.grayDark)
                                .frame(width: 80)
                            
                        }
                    }
        
                })
                
             
                
            }
        }
    }
}

#Preview {
    CategoryPicker(currentCategory: .constant(.nature))
}
