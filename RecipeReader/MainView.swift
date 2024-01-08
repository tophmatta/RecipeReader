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
    
    /*
     UX:
     1. Start scan
     2. Shows boxes around area of interest
     3. User taps 'Capture Photo' once it looks correct.
     4. Analyze the photo
     */
    @StateObject var vm = ViewModel()
    
    var body: some View {
        NavigationStack(path: $vm.path) {
            ZStack {
                TextScanner(image: $vm.image, text: $vm.text)
                    .navigationDestination(for: Route.self) { nav in
                        switch nav {
                        case .image:
                            CapturedImageView()
                                .environmentObject(vm)
                        }
                    }
            }
        }
    }
}
