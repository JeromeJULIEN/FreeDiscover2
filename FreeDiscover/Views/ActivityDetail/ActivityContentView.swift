//
//  ActivityContentView.swift
//  FreeDiscover
//
//  Created by apprenant70 on 03/11/2023.
//

import SwiftUI

struct ActivityContentView: View {
    @State private var isShareSheetPresented = false

    var body: some View {
        Button(action: {
            // Afficher le UIActivityViewController pour partager
            isShareSheetPresented.toggle()
        }) {
            Image(systemName: "square.and.arrow.up")
                .imageScale(.large)

            //            Text("Partager")
        }
        .sheet(isPresented: $isShareSheetPresented) {
            ShareSheet(activityItems: ["Partager"])
        }
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    let activityItems: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}

}


#Preview {
    ActivityContentView()
}
