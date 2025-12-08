//
//  GardenManager.swift
//  Mind Garden
//
//  Created by Dittrich, Jan - Student on 11/11/25.
//

import Foundation
import SwiftUI

@Observable
class GardenManager {
    
    // MARK: - Stored Data
    var plants: [Plant] = []
    var selectedPlant: Plant? = nil
    
    // History for Reflection Charts
    struct EmotionEntry: Identifiable {
        let id = UUID()
        let date: Date
        let emotion: Emotion
    }
    
    var emotionHistory: [EmotionEntry] = []
    
    // MARK: - Add Plant When Emotion Is Added
    func addPlant(_ emotion: Emotion) {
        var plant = Plant(emotion: emotion)
        
        // random stable position
        plant.x = CGFloat.random(in: 80...700)
        plant.y = CGFloat.random(in: 150...550)
        
        plants.append(plant)
        
        // Store in history for reflection
        emotionHistory.append(EmotionEntry(date: Date(), emotion: emotion))
    }
    
    // MARK: - Watering Logic
    func water(_ plant: Plant) {
        guard let index = plants.firstIndex(where: { $0.id == plant.id }) else { return }
        
        withAnimation(.easeInOut(duration: 0.4)) {
            plants[index].growth = min(plants[index].growth + 0.25, 1.0)
        }
        
        if plants[index].growth >= 1.0 && plants[index].stage < 4 {
            plants[index].stage += 1
            plants[index].growth = 0.35
        }
        
        plants[index].lastWatered = Date()
    }
}
