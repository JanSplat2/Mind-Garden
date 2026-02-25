//
//  EmotionalInsight.swift
//  Mind Garden
//
//  Created by Dittrich, Jan - Student on 2/25/26.
//


import Foundation
import SwiftData

struct EmotionalInsight: Identifiable {
    let id = UUID()
    let message: String
    let suggestion: String?
}

struct EmotionalInsightEngine {
    
    static func analyze(entries: [EmotionEntry]) -> EmotionalInsight? {
        
        let todayEntries = entries
            .filter { Calendar.current.isDateInToday($0.date) }
            .sorted { $0.date < $1.date }
        
        guard todayEntries.count >= 3 else { return nil }
        
        let emotions = todayEntries.map { $0.emotion }
        let negativeCount = emotions.filter { $0.type == .negative }.count
        let positiveCount = emotions.filter { $0.type == .positive }.count
        
        // 1️⃣ Negative Streak Detection
        if hasNegativeStreak(emotions) {
            print("Emotion now - \(String(describing: todayEntries.last?.emotion.type))")
            if(todayEntries.last?.emotion.type == .positive) {
                return EmotionalInsight(
                    message: "This is getting better by the minute.",
                    suggestion: "Keep on, this is the path to go"
                )
            } else if(todayEntries.last?.emotion.type == .neutral) {
                return EmotionalInsight(
                    message: "There will always be light at the end of a tunnel.",
                    suggestion: "I know, the next thing will be super."
                )
            } else {
                // 2️⃣ Majority Negative Today
                if negativeCount >= 3 && negativeCount > positiveCount {
                        return EmotionalInsight(
                            message: "Today seems emotionally challenging overall.",
                            suggestion: "Would reflecting on what triggered these feelings help?"
                        )
                } else {
                    return EmotionalInsight(
                        message: "I’ve noticed several difficult emotions in a row today. That can feel heavy.",
                        suggestion: "Would you like to pause for 60 seconds and take 5 slow breaths?"
                    )
                }
            }
                
        }
        
        // 2️⃣ Majority Negative Today
        if negativeCount >= 3 && negativeCount > positiveCount {
                return EmotionalInsight(
                    message: "Today seems emotionally challenging overall.",
                    suggestion: "Would reflecting on what triggered these feelings help?"
                )
        }
        
        // 3️⃣ Repeated Same Emotion
        if let repeated = mostFrequentNegativeEmotion(emotions) {
            return EmotionalInsight(
                message: "You've felt \(repeated.rawValue) multiple times today.",
                suggestion: suggestionForEmotion(repeated)
            )
        }
        
        return nil
    }
    
    // MARK: - Helpers
    
    private static func hasNegativeStreak(_ emotions: [Emotion]) -> Bool {
        var streak = 0
        for emotion in emotions {
            if emotion.type == .negative {
                streak += 1
                if streak >= 3 { return true }
            } else {
                streak = 0
            }
        }
        return false
    }
    
    private static func mostFrequentNegativeEmotion(_ emotions: [Emotion]) -> Emotion? {
        let negatives = emotions.filter { $0.type == .negative }
        let counts = Dictionary(grouping: negatives, by: { $0 })
            .mapValues { $0.count }
        
        return counts.first(where: { $0.value >= 3 })?.key
    }
    
    private static func suggestionForEmotion(_ emotion: Emotion) -> String {
        switch emotion {
        case .anxious:
            return "Try a grounding exercise: name 5 things you can see, 4 you can touch, 3 you can hear."
        case .sad:
            return "Would it help to write one kind sentence to yourself?"
        case .angry:
            return "Maybe step away for a short walk or stretch your body."
        case .tired:
            return "Perhaps your body needs rest. A short pause could help."
        default:
            return "Would you like to reflect on what’s behind this feeling?"
        }
    }
}
