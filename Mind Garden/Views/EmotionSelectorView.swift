//
//  EmotionSelectorView.swift
//  Mind Garden
//
//  Created by Dittrich, Jan - Student on 11/11/25.
//

import SwiftUI

struct EmotionSelectorView: View {
    var manager: GardenManager
    @Binding var showSelector: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Text("How are you feeling today?")
                .font(.title3.bold())
                .padding()
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                ForEach(Emotion.allCases) { emotion in
                    Button {
                        manager.addPlant(for: emotion)
                        withAnimation(.easeInOut) {
                            showSelector = false
                        }
                    } label: {
                        VStack {
                            Text(emotion.emoji)
                                .font(.system(size: 36))
                            Text(emotion.rawValue.capitalized)
                                .font(.caption)
                                .foregroundStyle(emotion.color)
                        }
                        .padding()
                        .background(.thinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .shadow(radius: 8)
        .padding()
    }
}

#Preview {
    EmotionSelectorView(manager: GardenManager(), showSelector: .constant(true))
}
