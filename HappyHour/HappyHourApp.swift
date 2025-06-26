//
//  HappyHourApp.swift
//  HappyHour
//
//  Created by Tim Smith on 6/22/25.
//

import SwiftUI
import SwiftData

@main
struct HappyHourApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Place.self)
        }
    }
}
