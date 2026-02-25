//
//  EmotionSelectorView.swift
//  Mind Garden
//

import SwiftUI

struct EmotionSelectorView: View {
    var garden: GardenManager
    @Binding var showEmotionPicker: Bool
    var gardenSize: CGSize
    var existingPlants: [Plant] = []

    @State private var name: String = ""
    @State private var description: String = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("How are you feeling today?")
                .font(.title.bold())

            TextField("Name", text: $name)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)

            TextEditor(text: $description)
                .frame(height: 80)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(.gray.opacity(0.4)))

            LazyVGrid(columns: [GridItem(.adaptive(minimum: 90))], spacing: 16) {
                ForEach(Emotion.allCases) { emotion in
                    Button {
                        guard !name.isEmpty else { return }
                        garden.addPlant(
                            emotion,
                            name: name,
                            text: description,
                            gardenSize: gardenSize,
                            existingPlants: existingPlants
                        )
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

            Button("Close") {
                showEmotionPicker = false
            }
            .padding(.top, 8)
        }
        .padding()
    }
}
