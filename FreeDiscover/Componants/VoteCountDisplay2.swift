//
//  VoteCountDisplay2.swift
//  FreeDiscover
//
//  Created by apprenant70 on 30/10/2023.
//

import SwiftUI

struct VoteCountDisplay2: View {
    var voteCount : Int
    
    var body: some View {
        ZStack {
            
                
            ZStack{
                RoundedRectangle(cornerRadius: 0)
                    .frame(width: 50,height: 20)
                    .foregroundColor(voteCount > 0 ? Color.blueFD : .socialRed)
                    .clipShape(
                        .rect(
                            topLeadingRadius: 10,
                            bottomLeadingRadius: 10,
                            bottomTrailingRadius: 0,
                            topTrailingRadius: 0
                        )
                    )
                HStack{

                    Text("\(voteCount) pts")
                        .font(.caption.bold())
                }
                .foregroundColor(.white)
            }
            ZStack {
                
                RoundedRectangle(cornerRadius: 0)
                    .frame(width: 30,height: 20)
                    .foregroundColor(Color.blueFD)
                Image(systemName:"hand.thumbsup.fill")
                    .font(.caption)
            }
            .offset(x: 40, y: 0)
            .foregroundColor(.white)
            ZStack {
                RoundedRectangle(cornerRadius: 0)
                    .frame(width: 30,height: 20)
                    .foregroundColor(Color.socialRed)
                    .clipShape(
                        .rect(
                            topLeadingRadius: 0,
                            bottomLeadingRadius: 0,
                            bottomTrailingRadius: 10,
                            topTrailingRadius: 10
                        )
                    )
                
                Image(systemName:"hand.thumbsdown.fill")
                    .font(.caption)
            }
            .offset(x: 70, y: 0)
            .foregroundColor(.white)
        }
       
        .shadow(color: Color.secondary, radius: 1)
    }
    
        
        
}

#Preview {
    VoteCountDisplay2(voteCount: -3)
}
