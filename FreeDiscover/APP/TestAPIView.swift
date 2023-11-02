//
//  TestAPIView.swift
//  FreeDiscover
//
//  Created by jerome julien on 25/10/2023.
//

import SwiftUI

struct TestAPIView: View {
    
    @EnvironmentObject var userRequest : APIUserRequestModel
    
    var body: some View {
        VStack{
            Text("User list")
            
        }
        .onAppear{
            Task{
                userRequest.allUser = await userRequest.fetchedUser()
            }
        }
        

    }
}

#Preview {
    TestAPIView().environmentObject(APIUserRequestModel())
}
