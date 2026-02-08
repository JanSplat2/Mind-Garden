//
//  StartView.swift
//  Mind Garden
//
//  Created by Dittrich, Jan - Student
//

import SwiftUI

struct StartView: View {
    @Bindable var garden: GardenManager
    @Binding var showGarden: Bool
    @Binding var showReflection: Bool

    var body: some View {
        ZStack {
            // OLD GitHub background gradient
            LinearGradient(colors: [Color.green.opacity(0.4), Color.cyan.opacity(0.2)],
                           startPoint: .top,
                           endPoint: .bottom)
                .ignoresSafeArea()

            VStack(spacing: 40) {
                Text("🌱 Mind Garden")
                    .font(.largeTitle.bold())
                    .padding(.top, 60)

                VStack(spacing: 20) {
                    Button("Open Garden") {
                        showGarden = true
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)

                    Button("Reflection") {
                        showReflection = true
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)

                    Button("Reset Garden") {
                        garden.resetGarden()
                    }
                    .buttonStyle(.bordered)
                    .foregroundColor(.red)
                }

                Spacer()
            }
            .padding()
        }
    }
}
