//
//  ContentView.swift
//  Mind Garden
//

import SwiftUI
import SwiftData
import Observation

struct ContentView: View {
    
    @Environment(\.modelContext) private var context
    @State private var garden: GardenManager
    
    @State private var showEmotionPicker = false
    @State private var showGarden = false
    @State private var showReflection = false
    
    init(context: ModelContext) {
        _garden = State(initialValue: GardenManager(context: context))
    }
    
    var body: some View {
        NavigationStack {
            if showGarden {
                NavigationSplitView {
                    SidebarView(garden: garden, showEmotionPicker: $showEmotionPicker)
                } detail: {
                    GardenView(garden: garden, showGarden: $showGarden)
                }
                .sheet(isPresented: $showEmotionPicker) {
                    GeometryReader { geo in
                        EmotionSelectorView(
                            garden: garden,
                            showEmotionPicker: $showEmotionPicker,
                            gardenSize: geo.size,
                            existingPlants: []
                        )
                    }
                    .frame(width: 450, height: 420)
                }
                .navigationTitle("Mind Garden 🌱")
            } else if showReflection {
                ReflectionView(garden: garden) {
                    showReflection = false
                }
                .navigationTitle("Reflection ✨")
            } else {
                StartView(
                    garden: garden,
                    showGarden: $showGarden,
                    showReflection: $showReflection
                )
            }
        }
        .sheet(item: $garden.insight) { insight in
            SupportView(
                insight: insight,
                dismissAction: {
                    garden.insight = nil
                }
            )
        }
    }
}
