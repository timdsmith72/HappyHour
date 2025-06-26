//
//  Places.swift
//  HappyHour
//
//  Created by Tim Smith on 6/22/25.
//

import Foundation
import SwiftData

@Model
class Place {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
