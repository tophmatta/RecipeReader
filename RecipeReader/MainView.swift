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
    
    var body: some View {
        NavigationStack(path: $vm.path) {
            ZStack {
                Color.white
                Button {
                    vm.append(value: Route.camera)
                } label: {
                    Text("Button")
                }
                .padding()
                .background(Color.mint)
                .foregroundStyle(.white)
                .clipShape(Capsule())
                .navigationDestination(for: Route.self) { nav in
                    switch nav {
                    case .imageResult:
                        //TODO: do something with captured image
                        CapturedImageView()
                            .environmentObject(vm)
                            .ignoresSafeArea()
                    case .camera:
                        CameraView()
                            .environmentObject(vm)
                            .ignoresSafeArea()
                    }
                }
            }
        }
    }
}
