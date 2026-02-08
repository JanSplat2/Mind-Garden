//
//  GardenManager.swift
//  Mind Garden
//

import Foundation
import SwiftUI
import SwiftData

@Observable
class GardenManager {

    private let context: ModelContext
    var selectedPlant: Plant?

    init(context: ModelContext) {
        self.context = context
    }

    func addPlant(_ emotion: Emotion, name: String, text: String, gardenSize: CGSize, existingPlants: [Plant]) {
        let plant = Plant(emotion: emotion)
        let pos = randomNonCollidingPosition(
            gardenSize: gardenSize,
            existingPlants: existingPlants,
            plantSize: 80,
            minDistance: 90
        )
        plant.x = pos.x
        plant.y = pos.y
        plant.name = name
        plant.text = text

        context.insert(plant)
        context.insert(EmotionEntry(date: Date(), emotion: emotion))

        do {
            try context.save()
            print("Plant inserted - \(name)")
        } catch {
            print("Failed to save plant:", error)
        }
    }

    func water(_ plant: Plant) {
        do {
            let plants = try context.fetch(FetchDescriptor<Plant>())
            guard let plantToWater = plants.first(where: { $0.id == plant.id }) else { return }

            withAnimation(.easeInOut(duration: 0.4)) {
                plantToWater.growth = min(plantToWater.growth + 0.25, 1.0)
            }

            if plantToWater.growth >= 1.0 && plantToWater.stage < 4 {
                plantToWater.stage += 1
                plantToWater.growth = 0.35
            }

            plantToWater.lastWatered = Date()
            try context.save()
        } catch {
            print("Failed to water plant:", error)
        }
    }

    func resetGarden() {
        do {
            let plants = try context.fetch(FetchDescriptor<Plant>())
            for plant in plants { context.delete(plant) }

            let emotions = try context.fetch(FetchDescriptor<EmotionEntry>())
            for entry in emotions { context.delete(entry) }

            try context.save()
            print("Garden successfully reset ")
        } catch {
            print("Failed to reset garden:", error)
        }
    }
}
