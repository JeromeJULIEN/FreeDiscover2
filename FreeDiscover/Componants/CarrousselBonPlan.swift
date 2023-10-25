//
//  CarrousselBonPlan.swift
//  FreeDiscover
//
//  Created by jerome julien on 21/10/2023.
//

import SwiftUI

struct CarrousselBonPlan: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .ignoresSafeArea()
                .frame(height: 200)
                .foregroundColor(.white)
                .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
            VStack(alignment : .leading){
                Text("Nos bon plan du moment")
                    .font(.headline)
                    .foregroundColor(.grayDark)
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing:40){
                        ForEach(getTemporaryActivities(),id: \.id){
                            activity in
                            NavigationLink(destination:ActivityDetailView()){
                                VStack(alignment:.leading){
                                    Image("\(activity.image)")
                                       .resizable()
                                       .aspectRatio(contentMode: .fill)
                                       .frame(width: 110, height: 110)
                                       .clipShape(RoundedRectangle(cornerRadius: 8))
                                    Text("\(activity.name)")
                                        .foregroundColor(.grayDark)
                                        .font(.headline)
                                        .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                                        .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                                }
                                .frame(width: 110)

                            }
                        }
                    }
                }
                
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .padding(.leading,10)
            .presentationDetents([.height(200), .large])
        }
    }
}

#Preview {
    CarrousselBonPlan()
}
