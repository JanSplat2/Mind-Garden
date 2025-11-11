//
//  ContentView.swift
//  Mind Garden
//
//  Created by Dittrich, Jan - Student on 11/11/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showSelector = false
    @State private var manager = GardenManager()
    
    var body: some View {
        NavigationStack {
            ZStack {
                GardenView(manager: manager)
                    .blur(radius: showSelector ? 8 : 0)
                    .animation(.easeInOut, value: showSelector)
                
                if showSelector {
                    EmotionSelectorView(manager: manager, showSelector: $showSelector)
                        .transition(.scale)
                }
            }
            .toolbar {
                Button {
                    withAnimation { showSelector.toggle() }
                } label: {
                    Label("Add Emotion", systemImage: "plus.circle.fill")
                }
            }
            .navigationTitle("Mind Garden 🌱")
        }
    }
}

#Preview {
    ContentView()
}
