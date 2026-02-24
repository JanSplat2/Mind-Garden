//
//  PlantView.swift
//  Mind Garden
//

import SwiftUI

struct PlantView: View {
    let plant: Plant
    var onWater: () -> Void

    // Animation states
    @State private var wiggle = false
    @State private var glow = false

    var body: some View {
        VStack(spacing: 6) {
            // Plant Graphic + animations
            plantGraphic
                .scaleEffect(0.8 + plant.growth * 0.4) // grow animation
                .rotationEffect(.degrees(wiggle ? 3 : 0)) // wiggle animation
                .shadow(color: glow ? plant.emotion.color.opacity(0.6) : .clear, radius: glow ? 22 : 0) // glow animation
                .animation(.easeInOut(duration: 0.35), value: plant.growth)
                .animation(.spring(duration: 0.25), value: wiggle)
                .animation(.easeInOut(duration: 0.8), value: glow)
                .onTapGesture {
                    triggerAnimations()
                    onWater()
                }

            // Water Button
            Button {
                triggerAnimations()
                onWater()
            } label: {
                Label("Water", systemImage: "drop.fill")
            }
            .buttonStyle(.borderedProminent)
            .tint(.blue.opacity(0.7))

            // NEW: Plant name and emotion emoji below Water button
            VStack(spacing: 2) {
                Text(plant.name)
                    .font(.caption.bold())
                    .foregroundColor(.primary)
                    .help(plant.text) // Shows description on hover
                Text(plant.emotion.emoji)
                    .font(.caption)
                    .help(plant.text) // Shows description on hover
            }
        }
        .padding(.vertical, 8)
        .animation(.easeInOut, value: plant.stage)
    }

    // MARK: - Animation trigger
    private func triggerAnimations() {
        // Wiggle animation
        wiggle = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { wiggle = false }

        // Glow animation ONLY when blooming
        if plant.stage == 4 {
            glow = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) { glow = false }
        }
    }

    // MARK: - Plant stages
    @ViewBuilder
    private var plantGraphic: some View {
        switch plant.stage {
        case 1: sprout
        case 2: smallPlant
        case 3: mediumPlant
        default: bloomingPlant
        }
    }

    private var sprout: some View {
        HStack {
            Capsule().fill(.green).frame(width: 22, height: 10)
            Capsule().fill(.green).frame(width: 22, height: 10)
        }
        .padding(.bottom, 5)
    }

    private var smallPlant: some View {
        ZStack {
            Leaf()
                .frame(width: 45, height: 90)
                .offset(x: -20)
            Leaf()
                .frame(width: 45, height: 90)
                .offset(x: 20)
        }
    }

    private var mediumPlant: some View {
        ZStack {
            Circle().fill(.green.opacity(0.7)).frame(width: 90)
            Circle().fill(.green).frame(width: 65)
        }
    }

    private var bloomingPlant: some View {
        ZStack {
            ForEach(Array(0..<6), id: \.self) { i in
                Ellipse()
                    .fill(plant.emotion.color.gradient)
                    .frame(width: 40, height: 60)
                    .rotationEffect(.degrees(Double(i) * 60))
            }
            Circle().fill(.yellow).frame(width: 40)
        }
    }
}
