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
    
    var body: some View {
        NavigationSplitView {
            SidebarView(garden: garden, showEmotionPicker: $showEmotionPicker)
        } detail: {
            GardenView(garden: garden)
        }
        .sheet(isPresented: $showEmotionPicker) {
            EmotionSelectorView(garden: garden, showEmotionPicker: $showEmotionPicker)
                .presentationDetents([.medium, .large])
        }
    }
}

#Preview {
    ContentView()
}
