//
//  Leaf.swift
//  Mind Garden
//
//  Created by Dittrich, Jan - Student on 12/1/25.
//

import SwiftUI

struct Leaf: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let w = rect.width
        let h = rect.height
        
        p.move(to: CGPoint(x: w/2, y: h))
        p.addQuadCurve(to: CGPoint(x: w, y: h/2),
                       control: CGPoint(x: w * 0.85, y: h * 0.9))
        p.addQuadCurve(to: CGPoint(x: w/2, y: 0),
                       control: CGPoint(x: w * 0.85, y: h * 0.1))
        p.addQuadCurve(to: CGPoint(x: 0, y: h/2),
                       control: CGPoint(x: w * 0.15, y: h * 0.1))
        p.addQuadCurve(to: CGPoint(x: w/2, y: h),
                       control: CGPoint(x: w * 0.15, y: h * 0.9))
        
        return p
    }
}
