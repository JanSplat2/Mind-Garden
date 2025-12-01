//
//  GardenManager.swift
//  Mind Garden
//
//  Created by Dittrich, Jan - Student on 11/11/25.
//

import SwiftUI

@Observable
class GardenManager {
    var plants: [Plant] = []
    var selectedPlant: Plant? = nil
    
    func addPlant(_ emotion: Emotion) {
        var plant = Plant(emotion: emotion)
        plant.x = CGFloat.random(in: 200...700)
        plant.y = CGFloat.random(in: 200...550)
        plants.append(plant)
    }
    
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
