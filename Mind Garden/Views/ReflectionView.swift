//
//  ReflectionView.swift
//  Mind Garden
//
//  Created by Dittrich, Jan - Student
//

import SwiftUI
import SwiftData
import Charts

struct ReflectionView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var garden: GardenManager
    /// Optional closure the parent can pass to dismiss the reflection view
    var onDone: (() -> Void)? = nil

    // MARK: - Fetch emotion history live from SwiftData
    @Query(sort: \EmotionEntry.date) private var emotionHistory: [EmotionEntry]

    // MARK: - Chart data models
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

    // MARK: - Process chart data
    private var emotionsPerDay: [DailyEmotionCount] {
        let grouped = Dictionary(grouping: emotionHistory) { entry in
            Calendar.current.startOfDay(for: entry.date)
        }
        return grouped.map { day, entries in
            DailyEmotionCount(date: day, count: entries.count)
        }
        .sorted { $0.date < $1.date }
    }

    private var emotionTypeDistribution: [EmotionTypeCount] {
        let grouped = Dictionary(grouping: emotionHistory) { entry in
            entry.emotion.rawValue
        }
        return grouped.map { type, entries in
            EmotionTypeCount(emotion: type.capitalized, count: entries.count)
        }
        .sorted { $0.emotion < $1.emotion }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 28) {
                    
                    // Title
                    Text("Reflection & Insights ✨")
                        .font(.largeTitle.bold())
                        .padding(.top, 20)
                    
                    Divider()
                    
                    // Chart 1 - Emotions per day
                    VStack(alignment: .leading, spacing: 12) {
                        Text(" Emotions Added Per Day")
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
                        Text(" Emotion Type Distribution")
                            .font(.title2.bold())
                        Chart(emotionTypeDistribution) { item in
                            BarMark(
                                x: .value("Count", item.count),
                                y: .value("Emotion", item.emotion)
                            )
                            .foregroundStyle(by: .value("Emotion", item.emotion))
                        }
                        .chartLegend(.visible)
                        .frame(height: 260)
                    }
                    
                    Divider()
                    
                    // Bottom Back / Done button
                    Button {
                        if let done = onDone { done() } else { dismiss() }
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
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        if let done = onDone { done() } else { dismiss() }
                    } label: {
                        Label("Back", systemImage: "arrow.left")
                    }
                }
            }
        }
    }
}
