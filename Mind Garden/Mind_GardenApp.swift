//
//  Mind_GardenApp.swift
//  Mind Garden
//
//  Created by Dittrich, Jan - Student on 11/11/25.
//

import SwiftUI
import SwiftData

@main
struct Mind_GardenApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Plant.self, EmotionEntry.self])
    }
}

