//
//  StartView.swift
//  Mind Garden
//
//  Created by Dittrich, Jan - Student on 12/2/25.
//

import SwiftUI
import SwiftData

struct StartView: View {
    @Bindable var garden: GardenManager
    @Binding var showGarden: Bool
    @Binding var showReflection: Bool
    
    // Fetch plants to show a count or placeholder if needed
    @Query(sort: \Plant.lastWatered) private var plants: [Plant]
    
    var body: some View {
        VStack(spacing: 40) {
            
            Text("Mind Garden")
                .font(.largeTitle.bold())
                .foregroundStyle(.green)
                .padding(.top, 40)
            
            Text("Grow your emotions.\nReflect on your day.")
                .font(.title3)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
            
            Spacer()
            
            // 🌱 Garden Button
            Button {
                showGarden = true
            } label: {
                VStack {
                    Image(systemName: "leaf.fill")
                        .font(.system(size: 42))
                    
                    Text("Enter Your Garden")
                        .font(.title3.bold())
                }
                .frame(width: 250, height: 120)
                .background(.green.opacity(0.25))
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            
            // ✨ Reflection Button
            Button {
                showReflection = true
            } label: {
                VStack {
                    Image(systemName: "sparkles")
                        .font(.system(size: 42))
                    
                    Text("Start Reflection")
                        .font(.title3.bold())
                }
                .frame(width: 250, height: 120)
                .background(.blue.opacity(0.25))
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            
            // Reset ␥
            Button {
                garden.resetGarden()
            } label: {
                VStack {
                    Image(systemName: "trash")
                        .font(.system(size: 42))
                    
                    Text("Reset Garden")
                        .font(.title3.bold())
                }
                .frame(width: 250, height: 120)
                .background(.red.opacity(0.25))
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            
            Spacer()
        }
        .padding()
    }
}

