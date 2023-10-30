//
//  ProfileImage.swift
//  FreeDiscover
//
//  Created by apprenant92 on 24/10/2023.
//

import SwiftUI
import PhotosUI


struct UserImage: View {
    let imageState: UserModel.ImageState
    
    var body: some View {
        switch imageState {
        case .success(let image):
            image.resizable()
        case .loading:
            ProgressView()
        case .empty:
            ZStack {
               // Image(systemName: "plus.square")
                //    .font(.system(size: 30))
                //    .foregroundColor(.white)
                Text("")
                    .foregroundColor(Color.grayDark)
  
            }
        case .failure:
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 40))
                .foregroundColor(.white)
        }
    }
}
// ressource existante pour la photo de profil
struct CircularProfileImage: View {
    let imageState: UserModel.ImageState
    
    var body: some View {
        UserImage(imageState: imageState)
            .scaledToFill()
            .clipShape(Circle())
            .frame(width: 100, height: 100)
            .background {
                Circle().fill(
                    LinearGradient(
                        colors: [.yellow, .orange],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
    }
}
// ressource existante pour le bouton + de la photo de profil
struct EditableCircularProfileImage: View {
    @ObservedObject var viewModel: UserModel
    
    var body: some View {
        CircularProfileImage(imageState: viewModel.imageState)
            .overlay(alignment: .bottomTrailing) {
                PhotosPicker(selection: $viewModel.imageSelection,
                             matching: .images,
                             photoLibrary: .shared()) {
                    Image(systemName: "pencil.circle.fill")
                        .symbolRenderingMode(.multicolor)
                        .font(.system(size: 30))
                        .foregroundColor(.accentColor)
                }
                .buttonStyle(.borderless)
            }
    }
}
