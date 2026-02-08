//
//  EmotionEntry.swift
//  Mind Garden
//

import Foundation
import SwiftData

@Model
class EmotionEntry {
    @Attribute(.unique) var id: UUID
    var date: Date
    var emotionRaw: String

    init(date: Date, emotion: Emotion) {
        self.id = UUID()
        self.date = date
        self.emotionRaw = emotion.rawValue
    }

    var emotion: Emotion {
        get { Emotion(rawValue: emotionRaw) ?? .neutral }
        set { emotionRaw = newValue.rawValue }
    }
}
