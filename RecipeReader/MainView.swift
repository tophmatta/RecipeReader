//
//  ContentView.swift
//  RecipeReader
//
//  Created by Toph Matta on 12/21/23.
//

import SwiftUI
import SwiftData
import VisionKit

struct MainView: View {
    
    @StateObject private var vm = ViewModel()
    @State private var isShown = false
    
    var body: some View {
        NavigationStack(path: $vm.path) {
            ZStack {
                
                CameraView(image: $vm.image, isShown: $isShown)
                    .navigationDestination(for: Route.self) { nav in
                        switch nav {
                        case .image:
                            CapturedImageView()
                                .environmentObject(vm)
                        }
                    }
                    .ignoresSafeArea()
            }
        }
    }
}
