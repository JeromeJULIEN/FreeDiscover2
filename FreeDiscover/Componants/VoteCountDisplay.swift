//
//  VoteCountDisplay.swift
//  FreeDiscover
//
//  Created by jerome julien on 19/10/2023.
//

import SwiftUI

struct VoteCountDisplay: View {
    var voteCount : Int
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 50,height: 20)
                .foregroundColor(voteCount > 0 ? Color.blueFD : .red)
            HStack{
                Text("\(voteCount)")
                    .font(.caption.bold())
                Image(systemName:voteCount > 0 ?  "hand.thumbsup.fill" : "hand.thumbsdown.fill")
                    .font(.caption)
            }
            .foregroundColor(.white)
        }
    }
}

#Preview {
    VoteCountDisplay(voteCount: -3)
}
