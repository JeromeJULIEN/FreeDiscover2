//
//  LoadingScreen.swift
//  FreeDiscover
//
//  Created by jerome julien on 06/11/2023.
//

import SwiftUI

struct LoadingScreen: View {
    @State var progress: CGFloat = 0
    @State var doneLoading: Bool = false
    
    var body: some View {
        ZStack{
            LoadingView(content:
        VStack {
                Image("fdLogo")
                
                    .resizable()
                    .scaledToFit()
                Text("freeDiscover")
                    .font(.title)
                    .foregroundColor(.accentColor)
                    .bold()
            }
//                        .background(.white)
                .padding(.horizontal,50),
                        progress: $progress)
            // Added to simulate asynchronous data loading
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        self.progress = 0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                        withAnimation {
                            self.doneLoading = true
                        }
                    }
                }
            }

            
            

        }
    }
}

#Preview {
    LoadingScreen()
}

struct LoadingView<Content: View>: View {
    
    var content: Content
    @Binding var progress: CGFloat
    @State var loadingOffset: CGFloat = 0 //Animation Y Offset
    
    var body: some View{
        content
            .modifier(ScaledMaskModifier(mask: RoundedRectangle(cornerRadius:20), progress: progress))
            .offset(x: 0,y: loadingOffset)
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 1)) {
                    self.progress = 1.0
                }
                withAnimation(Animation.easeInOut(duration: 0.4).repeatForever(autoreverses: true)) {
                    self.loadingOffset = 10
            }
        }
    }
}

struct ScaledMaskModifier<Mask: View>: ViewModifier {
    
    var mask: Mask
    var progress: CGFloat
    
    func body (content: Content) -> some View {
        content
            .mask(GeometryReader (content: { geometry in
                self.mask.frame(width: self.calculateSize (geometry: geometry) * self.progress,
                                height: self.calculateSize(geometry: geometry) * self.progress,
                                alignment: .center)
            }))
    }

    //     Calculate Max Size of Mask
        func calculateSize (geometry: GeometryProxy) -> CGFloat {
            if geometry.size.width > geometry.size.height {
                return geometry.size.width
            }
            return geometry.size.height
        }
    }
