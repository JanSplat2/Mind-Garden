//
//  GardenView.swift
//  Mind Garden
//
//  Created by Dittrich, Jan - Student on 11/11/25.
//

import SwiftUI

import SwiftUI

struct GardenView: View {
    @Bindable var manager: GardenManager
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                LinearGradient(colors: [.mint.opacity(0.6), .teal.opacity(0.3)],
                               startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
                
                ForEach(manager.plants) { plant in
                    PlantView(plant: plant)
                        .scaleEffect(plant.growth)
                        .animation(.spring(response: 0.6, dampingFraction: 0.5), value: plant.growth)
                        .position(
                            x: CGFloat.random(in: 60...(geo.size.width - 60)),
                            y: CGFloat.random(in: 150...(geo.size.height - 100))
                        )
                }
            }
        }
    }
}

#Preview {
    let manager = GardenManager()
    manager.addPlant(for: .joy)
    manager.addPlant(for: .calm)
    return GardenView(manager: manager)
}
