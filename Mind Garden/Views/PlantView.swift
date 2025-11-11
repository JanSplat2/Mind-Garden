//
//  PlantView.swift
//  Mind Garden
//
//  Created by Dittrich, Jan - Student on 11/11/25.
//

import SwiftUI

struct PlantView: View {
    let plant: Plant
    @State private var bloom = false
    
    var body: some View {
        VStack(spacing: 4) {
            Circle()
                .fill(plant.emotion.color.gradient)
                .frame(width: bloom ? 50 : 40, height: bloom ? 50 : 40)
                .overlay(Text(plant.emotion.emoji).font(.system(size: 25)))
                .shadow(radius: 6)
                .scaleEffect(bloom ? 1.1 : 1)
                .onAppear {
                    withAnimation(.spring(duration: 1.0)) {
                        bloom = true
                    }
                }
            Rectangle()
                .fill(.green)
                .frame(width: 5, height: 35)
        }
    }
}
