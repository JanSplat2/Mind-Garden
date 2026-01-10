//
//  Emotion.swift
//  Mind Garden
//
//  Created by Dittrich, Jan - Student on 11/11/25.
//

import SwiftUI

enum Emotion: String, CaseIterable, Identifiable, Hashable {
    case joy, calm, love, sadness, anger, anxiety, gratitude, neutral
    
    
    var id: String { rawValue }
    
    var color: Color {
        switch self {
        case .joy: return .yellow
        case .calm: return .blue
        case .love: return .pink
        case .sadness: return .gray
        case .anger: return .red
        case .anxiety: return .purple
        case .gratitude: return .green
        case .neutral: return .white
        }
    }
    
    var emoji: String {
        switch self {
        case .joy: return "😊"
        case .calm: return "🌊"
        case .love: return "❤️"
        case .sadness: return "💧"
        case .anger: return "🔥"
        case .anxiety: return "🌪️"
        case .gratitude: return "🌻"
        case .neutral: return " "
        }
    }
}

// Needed for Reflection Charts
extension Emotion {
    var type: String { rawValue }
}
