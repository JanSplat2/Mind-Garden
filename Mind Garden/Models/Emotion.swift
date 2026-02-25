//
//  Emotion.swift
//  Mind Garden
//

import SwiftUI

enum EmotionType {
    case positive
    case neutral
    case negative
}

enum Emotion: String, CaseIterable, Identifiable {
    
    case happy, sad, neutral, angry, excited, relaxed, anxious, loved, tired
    
    var id: String { rawValue }
    
    var emoji: String {
        switch self {
        case .happy: return "😊"
        case .sad: return "😢"
        case .neutral: return "😐"
        case .angry: return "😡"
        case .excited: return "🤩"
        case .relaxed: return "😌"
        case .anxious: return "😰"
        case .loved: return "🥰"
        case .tired: return "😴"
        }
    }
    
    var color: Color {
        switch self {
        case .happy: return .yellow
        case .sad: return .blue
        case .neutral: return .gray
        case .angry: return .red
        case .excited: return .orange
        case .relaxed: return .mint
        case .anxious: return .purple
        case .loved: return .pink
        case .tired: return .brown
        }
    }
    
    var type: EmotionType {
        switch self {
        case .happy, .excited, .relaxed, .loved:
            return .positive
            
        case .neutral:
            return .neutral
            
        case .sad, .angry, .anxious, .tired:
            return .negative
        }
    }
}
