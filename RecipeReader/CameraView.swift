//
//  DataScannerViewController.swift
//  RecipeReader
//
//  Created by Toph Matta on 1/2/24.
//

import Foundation
import SwiftUI
import VisionKit
import Combine


@MainActor
struct CameraView: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Binding var isShown: Bool
        
    func makeUIViewController(context: Context) -> some UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        if !UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .photoLibrary
        } else {
            picker.sourceType = .camera
        }
        return picker
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(isShown: $isShown, image: $image)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        @Binding var isShown: Bool
        @Binding var image: UIImage?

        init(isShown: Binding<Bool>, image: Binding<UIImage?>) {
            _isShown = isShown
            _image = image
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            isShown = false
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            isShown = false
        }
    }
    
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
}
