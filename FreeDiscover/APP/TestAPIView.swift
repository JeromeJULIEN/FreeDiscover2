//
//  TestAPIView.swift
//  FreeDiscover
//
//  Created by jerome julien on 25/10/2023.
//

import SwiftUI

struct TestAPIView: View {
    
    @StateObject var userRequest = UserAPIRequest()
    
    var body: some View {
        UserListView()
            .onAppear{
                Task{
                    userRequest.allUser = await userRequest.fetchedUser()
                }
            }
//            .environmentObject(UserRequest)
    }
}

#Preview {
    TestAPIView()
}
