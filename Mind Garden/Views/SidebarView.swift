//
//  SidebarView.swift
//  Mind Garden
//
//  Created by Dittrich, Jan - Student on 12/1/25.
//

import SwiftUI

struct SidebarView: View {
    @Bindable var garden: GardenManager
    @Binding var showEmotionPicker: Bool
    
    var body: some View {
        List(selection: $garden.selectedPlant) {
            Section("Your Plants") {
                if garden.plants.isEmpty {
                    ContentUnavailableView(
                        "No plants yet",
                        systemImage: "leaf",
                        description: Text("Add an emotion to grow your first plant.To do so, please press the + button in the top right corner in this darker window.")
                    )
                }
                
                ForEach(garden.plants) { plant in
                    Label(
                        plant.emotion.rawValue.capitalized,
                        systemImage: "leaf.fill"
                    )
                    .badge("Stage \(plant.stage)")
                    .tag(plant as Plant?)
                }
            }
        }
        .toolbar {
            Button {
                showEmotionPicker = true
            } label: {
                Label("Add Emotion", systemImage: "plus.circle")
            }
        }
    }
}

