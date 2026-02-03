//
//  SidebarView.swift
//  Mind Garden
//
//  Created by Dittrich, Jan - Student on 12/1/25.
//

import SwiftUI
import SwiftData

struct SidebarView: View {
    @Bindable var garden: GardenManager
    @Binding var showEmotionPicker: Bool
    
    // Fetch live list of plants
    @Query(sort: \Plant.lastWatered) private var plants: [Plant]
    
    var body: some View {
        NavigationStack {
            List(selection: $garden.selectedPlant) {
                Section("Your Plants") {
                    if plants.isEmpty {
                        ContentUnavailableView(
                            "No plants yet",
                            systemImage: "leaf",
                            description: Text("Add an emotion to grow your first plant. To do so, please press the + button in the top right corner in this window.")
                        )
                    }
                    
                    ForEach(plants) { plant in
                        Label(
                            plant.emotion.rawValue.capitalized,
                            systemImage: "leaf.fill"
                        )
                        .badge("Stage \(plant.stage)")
                        .tag(plant as Plant?)
                    }
                }
            }
            .navigationTitle("Your Garden 🌱")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                // Top-left Back button (in navigation bar only)
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        garden.selectedPlant = nil // or call a closure if parent handles navigation
                    } label: {
                        Label("Back", systemImage: "arrow.left")
                    }
                }
                
                // Top-right Add Emotion button (in navigation bar only)
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showEmotionPicker = true
                    } label: {
                        Label("Add Emotion", systemImage: "plus.circle")
                    }
                }
            }
        }
    }
}

