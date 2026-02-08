//
//  Plant.swift
//  Mind Garden
//
//  Created by Dittrich, Jan - Student
//

import SwiftUI
import SwiftData

@Model
class Plant {
    @Attribute(.unique) var id: UUID
    var emotionRaw: String
    var x: CGFloat
    var y: CGFloat
    var growth: Double
    var stage: Int
    var lastWatered: Date
    var name: String
    var text: String

    init(emotion: Emotion) {
        self.id = UUID()
        self.emotionRaw = emotion.rawValue
        self.x = 0
        self.y = 0
        self.growth = 0.0
        self.stage = 1
        self.lastWatered = Date()
        self.name = "unnamed"
        self.text = ""
    }

    var emotion: Emotion {
        get { Emotion(rawValue: emotionRaw) ?? .neutral }
        set { emotionRaw = newValue.rawValue }
    }
}
