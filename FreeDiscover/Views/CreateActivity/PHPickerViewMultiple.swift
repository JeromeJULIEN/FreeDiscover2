//
//  PHPickerViewMultiple.swift
//  FreeDiscover
//
//  Created by apprenant92 on 31/10/2023.
//
import SwiftUI
import PhotosUI

struct ImagePickerView: UIViewControllerRepresentable {
    
    let numOfSelectedPictures: Int // This is the number of selected photos
    @Binding var images: [UIImage]?
    
    init(numOfSelectedPictures: Int, images: Binding<[UIImage]?>) {
        self.numOfSelectedPictures = numOfSelectedPictures
        self._images = images
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        // Configuration
        let maxNumOfPictures = 5 - self.numOfSelectedPictures // Calculate the max num of photos
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = maxNumOfPictures // Set the max num of photos (0 is unlimited)
        configuration.filter = .any(of: [.images])
        // VC
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator // delegate
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(images: self.$images)
    }
    
}

// MARK; - Coordinator + PHPickerViewControllerDelegate
extension ImagePickerView {
    
    final class Coordinator: NSObject, PHPickerViewControllerDelegate {
        
        @Binding var images: [UIImage]?
        
        init(images: Binding<[UIImage]?>) {
            self._images = images
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            // Append all images into the binded array
            for result in results {
                
                let itemProvider = result.itemProvider
                
                if itemProvider.canLoadObject(ofClass: UIImage.self) {
                    
                    itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                        
                        DispatchQueue.main.async {
                            guard let safeImage = image as? UIImage else { return }
                            
                            if self?.images == nil {
                                self?.images = [safeImage]
                            } else {
                                self?.images?.append(safeImage)
                            }
                        }
                    }
                }
            }
        }
    }
    
}
