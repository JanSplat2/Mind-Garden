//
//  SupportView.swift
//  Mind Garden
//
//  Created by Dittrich, Jan - Student on 2/21/26.
//


import SwiftUI

struct SupportView: View {
    
    let message: String
    let dismissAction: () -> Void
    
    var body: some View {
        VStack(spacing: 24) {
            
            Text("Hey 🌱")
                .font(.largeTitle.bold())
            
            Text(message)
                .multilineTextAlignment(.center)
                .padding()
            
            Button("I'm okay ❤️") {
                dismissAction()
            }
            .buttonStyle(.borderedProminent)
            
            Button("I'd like to reflect ✨") {
                dismissAction()
            }
            .buttonStyle(.bordered)
        }
        .padding()
        .frame(width: 420, height: 300)
    }
}