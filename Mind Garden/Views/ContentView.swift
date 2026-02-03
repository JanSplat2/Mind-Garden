//
//  ContentView.swift
//  Mind Garden
//
//  Created by Dittrich, Jan - Student on 11/11/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    // MARK: - App State
    @Environment(\.modelContext) private var context
    @State private var garden: GardenManager?
    @State private var showEmotionPicker = false
    
    @State private var showGarden = false
    @State private var showReflection = false
    @State private var resetGarden = false
    
    var body: some View {
        NavigationStack {
            
            if let garden {
                // MARK: - GARDEN SCREEN
                if showGarden {
                    NavigationSplitView {
                        SidebarView(garden: garden, showEmotionPicker: $showEmotionPicker)
                    } detail: {
                        GardenView(garden: garden, showGarden: $showGarden)
                    }
                    .sheet(isPresented: $showEmotionPicker) {
                        EmotionSelectorView(garden: garden,
                                            showEmotionPicker: $showEmotionPicker)
                        .frame(width: 450, height: 420)
                    }
                    .navigationTitle("Mind Garden 🌱")
                    
                // MARK: - REFLECTION SCREEN
                } else if showReflection {
                    ReflectionView(garden: garden) {
                        showReflection = false
                    }
                    .navigationTitle("Reflection ✨")
                    
                // MARK: - START SCREEN
                } else {
                    StartView(garden: garden, showGarden: $showGarden,
                              showReflection: $showReflection
                              )
                }
                
            } else {
                // GardenManager not yet initialized
                Color.clear
                    .onAppear {
                        garden = GardenManager(context: context)
                    }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    let container = try! ModelContainer(for: Plant.self, EmotionEntry.self)
    let context = container.mainContext
    ContentView()
        .environment(\.modelContext, context)
}




