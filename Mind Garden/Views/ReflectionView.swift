//
//  ReflectionView.swift
//  Mind Garden
//
//  Created by Dittrich, Jan - Student on 11/11/25.
//

import SwiftUI

struct ReflectionView: View {
    @Bindable var garden: GardenManager
    @Binding var showReflection: Bool
    @State private var showEmotionPicker = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            // Escape Button
            Button {
                showReflection = false
            } label: {
                Label("Back", systemImage: "arrow.left.circle.fill")
                    .font(.title3)
                    .padding(10)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            
            Text("Reflection")
                .font(.largeTitle.bold())
                .padding(.top, 10)
            
            Text("Take a moment to write your thoughts or emotions. You can link your reflection to an emotional plant.")
                .multilineTextAlignment(.leading)
                .padding(.trailing)
                 
                 Button {
                showEmotionPicker = true
            } label: {
                Label("Add Emotion Plant", systemImage: "leaf.circle.fill")
                    .font(.title3.bold())
                    .padding()
                    .background(.green.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 14))
            }
                 
                 Spacer()
        }
        .padding()
        .sheet(isPresented: $showEmotionPicker) {
            EmotionSelectorView(garden: garden, showEmotionPicker: $showEmotionPicker)
                .frame(width: 450, height: 420)
        }
    }
}



