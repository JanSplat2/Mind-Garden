//
//  ContentView.swift
//  Mind Garden
//
//  Created by Dittrich, Jan - Student on 11/11/25.
//

import SwiftUI

struct ContentView: View {
    @State private var garden = GardenManager()
    @State private var showEmotionPicker = false
    
    @State private var showGarden = false
    @State private var showReflection = false
    
    var body: some View {
        NavigationStack {
            if showGarden {
                NavigationStack {
                    NavigationSplitView {
                        SidebarView(garden: garden, showEmotionPicker: $showEmotionPicker)
                    } detail: {
                        GardenView(garden: garden,
                                   showGarden: $showGarden)   // ← added binding
                    }
                    .sheet(isPresented: $showEmotionPicker) {
                        EmotionSelectorView(garden: garden, showEmotionPicker: $showEmotionPicker)
                    }
                    .navigationTitle("Mind Garden 🌱")
                }
            } else if showReflection {
    NavigationStack {
        ReflectionView(garden: garden,
                       showReflection: $showReflection) // ← NEW
            .navigationTitle("Reflection ✨")
        }
            } else {
                // 🏠 START SCREEN
                StartView(showGarden: $showGarden, showReflection: $showReflection)
            }
        }
    }
}

#Preview {
    ContentView()
}
