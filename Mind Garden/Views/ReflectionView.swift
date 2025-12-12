//
//  ReflectionView.swift
//  Mind Garden
//
//  Created by Dittrich, Jan - Student on 11/11/25.
//

import SwiftUI
import Charts

struct ReflectionView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var garden: GardenManager
    
    /// Optional closure the parent can pass to dismiss the reflection view.
    /// If nil, we fall back to calling the environment dismiss().
    var onDone: (() -> Void)? = nil
    
    // MARK: - Data models used by charts
    struct DailyEmotionCount: Identifiable {
        let id = UUID()
        let date: Date
        let count: Int
    }
    
    struct EmotionTypeCount: Identifiable {
        let id = UUID()
        let emotion: String
        let count: Int
    }
    
    // MARK: - Chart data
    
    /// Groups the garden's emotionHistory by day and returns counts per day
    private var emotionsPerDay: [DailyEmotionCount] {
        // Use the stored emotionHistory from GardenManager
        let grouped = Dictionary(grouping: garden.emotionHistory) { entry in
            Calendar.current.startOfDay(for: entry.date)
        }
        
        return grouped.map { (day, entries) in
            DailyEmotionCount(date: day, count: entries.count)
        }
        .sorted { $0.date < $1.date }
    }
    
    /// Counts how many times each emotion type appears in the history
    private var emotionTypeDistribution: [EmotionTypeCount] {
        let grouped = Dictionary(grouping: garden.emotionHistory) { entry in
            entry.emotion.rawValue
        }
        
        return grouped.map { (type, entries) in
            EmotionTypeCount(emotion: type.capitalized, count: entries.count)
        }
        .sorted { $0.emotion < $1.emotion }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                
                // Title
                Text("Reflection & Insights ✨")
                    .font(.largeTitle.bold())
                    .padding(.top, 20)
                
                Divider()
                
                // Chart 1 - Emotions per day
                VStack(alignment: .leading, spacing: 12) {
                    Text("📅 Emotions Added Per Day")
                        .font(.title2.bold())
                    
                    Chart(emotionsPerDay) { entry in
                        LineMark(
                            x: .value("Date", entry.date),
                            y: .value("Count", entry.count)
                        )
                        .symbol(.circle)
                        .foregroundStyle(.blue)
                        
                        AreaMark(
                            x: .value("Date", entry.date),
                            y: .value("Count", entry.count)
                        )
                        .foregroundStyle(.blue.opacity(0.15))
                    }
                    .chartXAxis {
                        AxisMarks(values: .automatic(desiredCount: 5)) { val in
                            AxisGridLine()
                            AxisTick()
                            AxisValueLabel(format: .dateTime.month().day())
                        }
                    }
                    .frame(height: 240)
                }
                
                Divider()
                
                // Chart 2 - Emotion type distribution
                VStack(alignment: .leading, spacing: 12) {
                    Text("🌱 Emotion Type Distribution")
                        .font(.title2.bold())
                    
                    Chart(emotionTypeDistribution) { item in
                        BarMark(
                            x: .value("Count", item.count),
                            y: .value("Emotion", item.emotion)
                        )
                        // Try to color the bar by matching the emotion string back to Emotion
                        .foregroundStyle(by: .value("Emotion", item.emotion))
                    }
                    .chartLegend(.visible)
                    .frame(height: 260)
                }
                
                Divider()
                
                // Back / Done button
                Button {
                    if let done = onDone {
                        done()
                    } else {
                        dismiss()
                    }
                } label: {
                    Text("⬅️ Back to Start")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.12))
                        .cornerRadius(12)
                }
                .padding(.bottom, 40)
            }
            .padding(.horizontal)
        }
        .onAppear {
            // Chart color mapping: For better legend colors, register a color mapping
            // (Charts can pick color from the series if provided; using default for now)
        }
    }
}

// Preview
#Preview {
    @Previewable @State var previewGarden = GardenManager()
    // add some fake history for previewing
    previewGarden.emotionHistory = [
        GardenManager.EmotionEntry(date: Date().addingTimeInterval(-86400 * 2), emotion: .joy),
        GardenManager.EmotionEntry(date: Date().addingTimeInterval(-86400 * 2), emotion: .joy),
        GardenManager.EmotionEntry(date: Date().addingTimeInterval(-86400), emotion: .calm),
        GardenManager.EmotionEntry(date: Date().addingTimeInterval(-86400), emotion: .love),
        GardenManager.EmotionEntry(date: Date(), emotion: .gratitude),
    ]
    
    return ReflectionView(garden: previewGarden)
}
