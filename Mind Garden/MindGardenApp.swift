//
//  MindGardenApp.swift
//  Mind Garden
//

import SwiftUI
import SwiftData

@main
struct MindGardenApp: App {
    
    let container: ModelContainer

    init() {
        do {
            // SwiftData Container für die Models
            container = try ModelContainer(
                for: Plant.self,
                     EmotionEntry.self
            )
            print("ModelContainer successfully loaded")
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView(context: container.mainContext)
                .environment(\.modelContext, container.mainContext)
        }
    }
}
