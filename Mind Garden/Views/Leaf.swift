//
//  Leaf.swift
//  Mind Garden
//
//  Created by Dittrich, Jan - Student
//

import SwiftUI

struct Leaf: View {
    var body: some View {
        Image(systemName: "leaf.fill")
            .resizable()
            .scaledToFit()
            .foregroundColor(.green)
    }
}
