//
//  ImagePicker.swift
//  FreeDiscover
//
//  Created by apprenant92 on 25/10/2023.
//

import Foundation
import UIKit
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var selectedImage: UIImage?
    @Binding var isPickerShowing: Bool
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        //object that can receive UIImagePickerController events
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
}

class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var parent: ImagePicker
    init(_ picker: ImagePicker) {
        self.parent = picker
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        
        //run code when the user has cancelled the picker UI
        print("Cancelled")
        
        //dismiss the picker
        parent.isPickerShowing = false
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //run code when the user has selected an image
        print("Image selected")
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            //we were able to get the image
            DispatchQueue.main.async {
                self.parent.selectedImage = image
            }
            
        }
        //dismiss the picker
        parent.isPickerShowing = false
        
    }
}
