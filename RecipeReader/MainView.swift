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
    @State private var image: UIImage?
    
    var body: some View {
        ZStack {
            TextScanner(image: $image)
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
            }
        }
    }
}
