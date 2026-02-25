//
//  SidebarView.swift
//  Mind Garden
//

import SwiftUI

struct SidebarView: View {
    var garden: GardenManager
    @Binding var showEmotionPicker: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            
            Button(action: { showEmotionPicker = true }) {
                Label("Add Plant", systemImage: "plus.circle")
            }
            
            Button(action: { garden.resetGarden() }) {
                Label("Reset Garden", systemImage: "trash")
                    .foregroundColor(.red)
            }
            
            Spacer()
        }
        .padding()
    }
}
