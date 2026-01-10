//
//  GardenManager.swift
//  Mind Garden
//
//  Created by Dittrich, Jan - Student on 11/11/25.
//

import Foundation
import SwiftUI
import SwiftData

@Observable
class GardenManager {

    // MARK: - SwiftData Context
    private let context: ModelContext

    // MARK: - Selected Plant
    var selectedPlant: Plant?

    // MARK: - Init
    init(context: ModelContext) {
        self.context = context
    }

    // MARK: - Add Plant When Emotion Is Added
    func addPlant(_ emotion: Emotion) {
        let plant = Plant(emotion: emotion)

        // Random stable position
        plant.x = CGFloat.random(in: 80...700)
        plant.y = CGFloat.random(in: 150...550)

        // Insert into context
        context.insert(plant)
        context.insert(EmotionEntry(date: Date(), emotion: emotion))

        saveContext()
    }

    // MARK: - Watering Logic
    func water(_ plant: Plant) {
        do {
            // Fetch all plants and find the one to water
            let plants = try context.fetch(FetchDescriptor<Plant>())
            guard let plantToWater = plants.first(where: { $0.id == plant.id }) else { return }

            // Animate growth
            withAnimation(.easeInOut(duration: 0.4)) {
                plantToWater.growth = min(plantToWater.growth + 0.25, 1.0)
            }

            // Advance stage if fully grown
            if plantToWater.growth >= 1.0 && plantToWater.stage < 4 {
                plantToWater.stage += 1
                plantToWater.growth = 0.35
            }

            plantToWater.lastWatered = Date()

            saveContext()
        } catch {
            print("Failed to water plant: \(error)")
        }
    }

    // MARK: - Reset Garden
    func resetGarden() {
        do {
            // Delete all plants
            let plants = try context.fetch(FetchDescriptor<Plant>())
            for plant in plants { context.delete(plant) }

            // Delete all emotion entries
            let emotions = try context.fetch(FetchDescriptor<EmotionEntry>())
            for entry in emotions { context.delete(entry) }

            // Save changes
            try context.save()

            print("Garden successfully reset ✅")
        } catch {
            print("Failed to reset garden: \(error)")
        }
    }

    // MARK: - Save Context Helper
    private func saveContext() {
        do {
            try context.save()
            // No need for objectWillChange.send() with @Observable + @Query
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}
