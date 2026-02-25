//
//  GardenView.swift
//  Mind Garden
//

import SwiftUI
import SwiftData

struct GardenView: View {
    var garden: GardenManager
    @Binding var showGarden: Bool
    @Query(sort: \Plant.lastWatered) private var plants: [Plant]
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .topLeading) {

                // Background
                LinearGradient(colors: [.green.opacity(0.4), .cyan.opacity(0.2)],
                               startPoint: .top,
                               endPoint: .bottom)
                    .ignoresSafeArea()

                // Escape button
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

                // Plants
                if plants.isEmpty {
                    ContentUnavailableView("No Plants, add some Flowers with the + in the left corner!",
                                           systemImage: "leaf")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ForEach(plants) { plant in
                        DraggablePlantView(
                            plant: plant,
                            allPlants: plants,
                            gardenSize: geo.size
                        ) {
                            garden.water(plant)
                        }
                    }
                }
            }
        }
    }
}
