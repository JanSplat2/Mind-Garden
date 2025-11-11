//
//  Plant.swift
//  Mind Garden
//
//  Created by Dittrich, Jan - Student on 11/11/25.
//

import SwiftUI

struct Plant: Identifiable {
    let id = UUID()
    let emotion: Emotion
    var growth: Double = 0.2  // from 0.0 to 1.0
    var date: Date = .now
}
