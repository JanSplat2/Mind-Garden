//
//  ContentView.swift
//  Mind Garden
//
//  Created by Dittrich, Jan - Student on 11/11/25.
//


import SwiftUI

struct ContentView: View {
    
    // MARK: - App State
    
    @State private var garden = GardenManager()
    @State private var showEmotionPicker = false
    
    @State private var showGarden = false
    @State private var showReflection = false
    
    var body: some View {
        NavigationStack {
            
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
                // pass a closure to set the flag back to false when user taps back
                ReflectionView(garden: garden) {
                    showReflection = false
                }
                .navigationTitle("Reflection ✨")
                
                // MARK: - START SCREEN
            } else {
                StartView(showGarden: $showGarden, showReflection: $showReflection)
            }
        }
    }
}

#Preview {
    ContentView()
}
