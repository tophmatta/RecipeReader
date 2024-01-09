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
    @EnvironmentObject var vm: ViewModel
        
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
        return Coordinator(vm: _vm)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        @EnvironmentObject var vm: ViewModel

        init(vm: EnvironmentObject<ViewModel>) {
            _vm = vm
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            vm.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            vm.pop()
        }
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}
