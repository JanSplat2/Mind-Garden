//
//  ReflectionView.swift
//  Mind Garden
//
//  Created by Dittrich, Jan - Student on 11/11/25.
//

import SwiftUI

struct ReflectionView: View {
    @State private var reflection = ""
    
    var body: some View {
        VStack {
            Text("Daily Reflection 🌼")
                .font(.title2.bold())
                .padding(.top)
            
            TextEditor(text: $reflection)
                .padding()
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .frame(height: 200)
                .padding()
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ReflectionView()
}
