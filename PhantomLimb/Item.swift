//
//  Item.swift
//  PhantomLimb
//
//  Created by xz353 on 2/14/24.
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
