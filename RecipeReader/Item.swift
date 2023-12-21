//
//  Item.swift
//  RecipeReader
//
//  Created by Toph Matta on 12/21/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
