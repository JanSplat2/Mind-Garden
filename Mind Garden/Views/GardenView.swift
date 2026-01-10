//
//  GardenView.swift
//  Mind Garden
//
//  Created by Dittrich, Jan - Student on 11/11/25.
//

import SwiftUI
import SwiftData

struct GardenView: View {
    @Bindable var garden: GardenManager
    @Binding var showGarden: Bool
    
    // Fetch live list of plants from SwiftData
    @Query(sort: \Plant.lastWatered) private var plants: [Plant]
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            
            // MARK: - Background
            LinearGradient(colors: [.green.opacity(0.4), .cyan.opacity(0.2)],
                           startPoint: .top,
                           endPoint: .bottom)
                .ignoresSafeArea()
            
            // MARK: - Escape Button
            VStack {
                Spacer()
                HStack {
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
            
            // MARK: - Plants
            if plants.isEmpty {
                ContentUnavailableView("No Plants, add some Flowers with the + in the left corner!",
                                       systemImage: "leaf")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ForEach(plants) { plant in
                    PlantView(plant: plant) {
                        garden.water(plant)
                    }
                    .position(x: plant.x, y: plant.y)
                }
            }
        }
    }
}
