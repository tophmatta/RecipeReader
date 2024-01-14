//
//  CapturedImageView.swift
//  RecipeReader
//
//  Created by Toph Matta on 1/5/24.
//

import Foundation
import SwiftUI

struct CapturedImageView: View {
    
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        ZStack {
            Color.gray.edgesIgnoringSafeArea(.all)
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
            }
        }
        .sheet(isPresented: $vm.showTranscript) {
            Text(vm.transcript ?? "no text")
        }
    }
    
}
