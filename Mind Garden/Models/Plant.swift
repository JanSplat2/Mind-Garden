//
//  Plant.swift
//  Mind Garden
//
//  Created by Dittrich, Jan - Student on 11/11/25.
//

import SwiftUI

struct Plant: Identifiable, Hashable {
    
    var createdAt: Date = Date()
    
    let id = UUID()
    let emotion: Emotion
    
    var growth: Double = 0.3
    var stage: Int = 1
    var lastWatered = Date()
    
    var x: CGFloat = CGFloat.random(in: 200...700)
    var y: CGFloat = CGFloat.random(in: 200...550)
}

