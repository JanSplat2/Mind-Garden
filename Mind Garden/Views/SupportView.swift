//
//  SupportView.swift
//  Mind Garden
//
//  Created by Dittrich, Jan - Student on 2/21/26.
//


import SwiftUI

struct SupportView: View {
    
    let insight: EmotionalInsight
    let dismissAction: () -> Void
    
    var body: some View {
        VStack(spacing: 24) {
            
            Text("Hey 🌱")
                .font(.largeTitle.bold())
            
            Text(insight.message)
                .multilineTextAlignment(.center)
            
            if let suggestion = insight.suggestion {
                Text(suggestion)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            
            Button("I'm okay ❤️") {
                dismissAction()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .frame(width: 420, height: 300)
    }
}
