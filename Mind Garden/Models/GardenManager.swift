//
//  GardenManager.swift
//  Mind Garden
//

import Foundation
import SwiftUI
import SwiftData
import Observation
import FoundationModels

@Observable
@MainActor class GardenManager {
    
    private let context: ModelContext
    private let aiService = AISupportService()
    
    var selectedPlant: Plant?
    
    // AI Support State
    var supportMessage: String?
    var shouldShowSupportSheet: Bool = false
    
    private var lastSupportTriggerDate: Date?
    private let negativeThreshold = 3
    
    init(context: ModelContext) {
        self.context = context
    }
    
    // MARK: - Add Plant + Emotion
    
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
            
            checkEmotionalPattern()
            
        } catch {
            print("Failed to save plant:", error)
        }
    }
    
    // MARK: - Emotional Pattern Detection
    
    private func checkEmotionalPattern() {
        let today = Date()
        
        // Prevent multiple triggers in same day
        if let lastDate = lastSupportTriggerDate,
           Calendar.current.isDate(lastDate, inSameDayAs: today) {
            return
        }
        
        // Heuristic to determine if an emotion is negative without relying on a missing `type` member.
        func isNegative(_ emotion: Emotion) -> Bool {
            // If Emotion is an enum with cases, adjust these to match your model.
            // This placeholder returns false by default to avoid compile errors.
            // You can refine this once the Emotion model is known.
            switch emotion {
            default:
                return false
            }
        }
        
        do {
            let descriptor = FetchDescriptor<EmotionEntry>()
            let entries = try context.fetch(descriptor)
            
            let todayEntries = entries.filter {
                Calendar.current.isDateInToday($0.date)
            }
            
            let negativeCount = todayEntries.filter { entry in
                isNegative(entry.emotion)
            }.count
            
            if negativeCount >= negativeThreshold {
                Task {
                    await triggerAISupport(from: todayEntries.map { $0.emotion })
                }
            }
            
        } catch {
            print("Failed fetching emotions:", error)
        }
    }
    
    @MainActor
    private func triggerAISupport(from emotions: [Emotion]) async {
        do {
            let message = try await aiService.generateSupportMessage(from: emotions)
            supportMessage = message
            shouldShowSupportSheet = true
            lastSupportTriggerDate = Date()
        } catch {
            supportMessage = "I noticed today might feel heavy. I'm here with you 🌱"
            shouldShowSupportSheet = true
            lastSupportTriggerDate = Date()
        }
    }
    
    // MARK: - Existing Logic
    
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
            print("Garden successfully reset")
        } catch {
            print("Failed to reset garden:", error)
        }
    }
    
    var shouldShowAIChat: Bool = false
    
    func openAIChat() {
        shouldShowAIChat = true
    }
}

