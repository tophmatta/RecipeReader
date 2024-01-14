//
//  ViewModel.swift
//  RecipeReader
//
//  Created by Toph Matta on 1/5/24.
//

import Foundation
import UIKit
import SwiftUI
import VisionKit
import Combine

@MainActor
class ViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var text: String? = nil
    @Published var path = NavigationPath()
    @Published var transcript: String? = nil
    @Published var showTranscript = false
    
    private var bag = Set<AnyCancellable>()
    
    lazy var imageAnalyzer: ImageAnalyzer = {
       return ImageAnalyzer()
    }()
    
    init() {
        subscribe()
    }
    
    deinit {
        bag.removeAll()
    }
    
    func subscribe() {
        $image
            .sink { [weak self] image in
                guard let self, let image = image else { return }
                onImageReceived(image)
                goTo(.imageResult)
            }
            .store(in: &bag)
    }
    
    func goTo(_ route: Route) {
        append(value: route)
    }

    func append<T: Hashable>(value: T) {
        path.append(value)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func onImageReceived(_ image: UIImage) {
        Task {
            transcript = await analyzeImageForText(image)
            showTranscript = true
        }
    }
    
    func analyzeImageForText(_ image: UIImage) async -> String {
        return try! await imageAnalyzer.analyze(image, orientation: .up, configuration: ImageAnalyzer.Configuration.init(ImageAnalyzer.AnalysisTypes.text)).transcript
    }
}

enum Route {
    case imageResult, camera
}
