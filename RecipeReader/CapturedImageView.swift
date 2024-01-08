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
            if let img = vm.image {
                Image(uiImage: img)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
            }
        }
    }
}
