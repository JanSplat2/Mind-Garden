//
//  EmotionSelectorView.swift
//  Mind Garden
//
//  Created by Dittrich, Jan - Student on 11/11/25.
//

import SwiftUI

struct EmotionSelectorView: View {
    @Bindable var garden: GardenManager
    @Binding var showEmotionPicker: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("How are you feeling?")
                .font(.title.bold())
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 90))], spacing: 16) {
                ForEach(Emotion.allCases) { emotion in
                    Button {
                        garden.addPlant(emotion)
                        showEmotionPicker = false
                    } label: {
                        VStack {
                            Text(emotion.emoji)
                                .font(.system(size: 45))
                            Text(emotion.rawValue.capitalized)
                                .foregroundStyle(emotion.color)
                        }
                        .frame(width: 110, height: 110)
                        .background(.thinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                    }
                }
            }
            
            Button("Close") { showEmotionPicker = false }
                .padding(.top, 8)
        }
        .padding()
    }
}
