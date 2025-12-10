//
//  GardenView.swift
//  Mind Garden
//
//  Created by Dittrich, Jan - Student on 11/11/25.
//

import SwiftUI

struct GardenView: View {
    @Bindable var garden: GardenManager
    @Binding var showGarden: Bool
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            
            // Background
            LinearGradient(colors: [.green.opacity(0.4), .cyan.opacity(0.2)],
                           startPoint: .top,
                           endPoint: .bottom)
            .ignoresSafeArea()
            
            // Escape Button
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Button {
                        showGarden = false
                    } label: {
                        Label("Back", systemImage: "arrow.left.circle.fill")
                            .font(.title3)
                            .padding(10)
                            .background(.regularMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .padding()
                    }
                }
            }
                
            // Plants
            if garden.plants.isEmpty {
                ContentUnavailableView("No Plants, add some Flowers with the + in the left corner!" , systemImage: "leaf")
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
