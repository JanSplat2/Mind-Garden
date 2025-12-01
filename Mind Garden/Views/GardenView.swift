//
//  GardenView.swift
//  Mind Garden
//
//  Created by Dittrich, Jan - Student on 11/11/25.
//

import SwiftUI

struct GardenView: View {
    @Bindable var garden: GardenManager
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.green.opacity(0.35), .cyan.opacity(0.25)],
                           startPoint: .top,
                           endPoint: .bottom)
            .ignoresSafeArea()
            
            if garden.plants.isEmpty {
                ContentUnavailableView("No Plants", systemImage: "leaf")
            } else {
                ForEach(garden.plants) { plant in
                    PlantView(plant: plant) {
                        garden.water(plant)
                    }
                    .position(x: plant.x, y: plant.y)
                }
            }
        }
    }
}
