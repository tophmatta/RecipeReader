//
//  ViewModel.swift
//  RecipeReader
//
//  Created by Toph Matta on 1/5/24.
//

import Foundation
import UIKit
import SwiftUI


class ViewModel: ObservableObject {
    @Published var image: UIImage? = nil {
        didSet {
            guard image != nil else { return }
            append(value: Route.image)
        }
    }
    @Published var text: String? = nil
    @Published var path = NavigationPath()

    func append<T: Hashable>(value: T) {
        path.append(value)
    }
    
}

enum Route {
    case image
}
