//
//  randomNonCollidingPosition.swift
//

import SwiftUI

func randomNonCollidingPosition(
    gardenSize: CGSize,
    existingPlants: [Plant],
    plantSize: CGFloat,
    minDistance: CGFloat,
    maxAttempts: Int = 50
) -> CGPoint {
    for _ in 0..<maxAttempts {
        let x = CGFloat.random(in: plantSize...(gardenSize.width - plantSize))
        let y = CGFloat.random(in: plantSize...(gardenSize.height - plantSize))
        let candidate = CGPoint(x: x, y: y)

        let collides = existingPlants.contains { plant in
            let dx = plant.x - candidate.x
            let dy = plant.y - candidate.y
            let distance = sqrt(dx*dx + dy*dy)
            return distance < minDistance
        }

        if !collides { return candidate }
    }

    return CGPoint(x: gardenSize.width/2, y: gardenSize.height/2)
}
