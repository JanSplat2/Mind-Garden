//
//  DraggablePlantView.swift
//  Mind Garden
//

import SwiftUI

struct DraggablePlantView: View {
    @Bindable var plant: Plant
    var allPlants: [Plant]
    var gardenSize: CGSize
    var onWater: () -> Void

    @State private var dragOffset: CGSize = .zero

    var body: some View {
        PlantView(plant: plant, onWater: onWater)
            .position(x: plant.x + dragOffset.width, y: plant.y + dragOffset.height)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        dragOffset = value.translation
                    }
                    .onEnded { _ in
                        var newX = plant.x + dragOffset.width
                        var newY = plant.y + dragOffset.height

                        // Boundaries
                        newX = max(50, min(newX, gardenSize.width - 50))
                        newY = max(50, min(newY, gardenSize.height - 50))

                        plant.x = newX
                        plant.y = newY
                        dragOffset = .zero
                    }
            )
    }
}
