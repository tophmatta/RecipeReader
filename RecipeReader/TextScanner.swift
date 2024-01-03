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
        
        let scanButton = createButton(text: "Start Scan", background: UIColor.blue)
        scanButton.addTarget(context.coordinator, action: #selector(Coordinator.startScanning(_:)), for: .touchUpInside)
        scannerViewController.view.addSubview(scanButton)
        
        let saveButton = createButton(text: "Save Text", background: UIColor.green)
        scanButton.addTarget(context.coordinator, action: #selector(Coordinator.save(_:)), for: .touchUpInside)
        scannerViewController.view.addSubview(saveButton)

        let stackView = createStackView(views: [scanButton, saveButton])
        scannerViewController.view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: scannerViewController.view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: scannerViewController.view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
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
        
        func dataScanner(_ dataScanner: DataScannerViewController, didAdd addedItems: [RecognizedItem], allItems: [RecognizedItem]) {
//            allItems.forEach{ printItem($0) }
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didRemove removedItems: [RecognizedItem], allItems: [RecognizedItem]) {}
        func dataScanner(_ dataScanner: DataScannerViewController, didUpdate updatedItems: [RecognizedItem], allItems: [RecognizedItem]) {}
        func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
            item.printText()
        }
        
        @objc func startScanning(_ sender: UIButton) {
            try? parent.scannerViewController.startScanning()
        }
        
        @objc func save(_ sender: UIButton) {
//            try? parent.scannerViewController.
        }
        

    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
    func createButton(text: String, background: UIColor) -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = background
        button.layer.cornerRadius = 5
        button.setTitle(text, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 50),
            button.widthAnchor.constraint(equalToConstant: 100)
        ])

        return button
    }
    
    func createStackView(views: [UIButton]) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        views.forEach{
            stackView.addArrangedSubview($0)
        }
        
        return stackView
    }
}

extension RecognizedItem {
    func printText() {
        switch self {
        case .text(let text):
            print(text.transcript)
        case .barcode(_):
            fallthrough
        @unknown default:
            break
        }
    }

}



