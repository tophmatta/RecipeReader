//
//  DataScannerViewController.swift
//  RecipeReader
//
//  Created by Toph Matta on 1/2/24.
//

import Foundation
import SwiftUI
import VisionKit


@MainActor
struct TextScanner: UIViewControllerRepresentable {

    var scannerViewController: DataScannerViewController = DataScannerViewController(
        recognizedDataTypes: [.text()],
        qualityLevel: .balanced,
        recognizesMultipleItems: true,
        isHighFrameRateTrackingEnabled: true,
        isHighlightingEnabled: true)
    
    func makeUIViewController(context: Context) -> some DataScannerViewController {
        scannerViewController.delegate = context.coordinator
        
        let scanButton = UIButton(type: .system)
        scanButton.backgroundColor = UIColor.systemBlue
        scanButton.layer.cornerRadius = 5
        scanButton.setTitle("Start Scan", for: .normal)
        scanButton.setTitleColor(UIColor.white, for: .normal)
        scanButton.addTarget(context.coordinator, action: #selector(Coordinator.startScanning(_:)), for: .touchUpInside)
        scannerViewController.view.addSubview(scanButton)
        
        scanButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scanButton.centerXAnchor.constraint(equalTo: scannerViewController.view.centerXAnchor),
            scanButton.bottomAnchor.constraint(equalTo: scannerViewController.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            scanButton.heightAnchor.constraint(equalToConstant: 50),
            scanButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        return scannerViewController
    }
    
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, DataScannerViewControllerDelegate {
        var parent: TextScanner
        
        init(_ parent: TextScanner) {
            self.parent = parent
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didAdd addedItems: [RecognizedItem], allItems: [RecognizedItem]) {}
        func dataScanner(_ dataScanner: DataScannerViewController, didRemove removedItems: [RecognizedItem], allItems: [RecognizedItem]) {}
        func dataScanner(_ dataScanner: DataScannerViewController, didUpdate updatedItems: [RecognizedItem], allItems: [RecognizedItem]) {}
        func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {}
        
        @objc func startScanning(_ sender: UIButton) {
            try? parent.scannerViewController.startScanning()
        }
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

