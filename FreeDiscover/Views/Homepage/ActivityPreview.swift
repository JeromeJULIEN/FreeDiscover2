//
//  ActivityPreview.swift
//  FreeDiscover
//
//  Created by jerome julien on 26/10/2023.
//

import SwiftUI

struct ActivityPreview: View {
    var body: some View {
        ZStack{
            Text("Activity preview")
        }
        .presentationDetents([ .height(200)])
        .presentationBackgroundInteraction(.enabled(upThrough: .height(200)))
    }
       
}

#Preview {
    ActivityPreview()
}
