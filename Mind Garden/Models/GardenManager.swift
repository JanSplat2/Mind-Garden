//
//  GardenManager.swift
//  Mind Garden
//
//  Created by Dittrich, Jan - Student on 11/11/25.
//

import SwiftUI
import Observation

@Observable
class GardenManager {
    var plants: [Plant] = []
    
    func addPlant(for emotion: Emotion) {
        var newPlant = Plant(emotion: emotion)
        newPlant.growth = 0.2
        plants.append(newPlant)
        grow(plantID: newPlant.id)
    }
    
    func grow(plantID: UUID) {
        if let index = plants.firstIndex(where: { $0.id == plantID }) {
            withAnimation(.easeInOut(duration: 1.2)) {
                plants[index].growth = min(plants[index].growth + 0.5, 1.0)
            }
        }
    }
}
