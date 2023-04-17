//
//  CustomCurveShape.swift
//  PRORecipies
//
//  Created by Victoria Spirchina on 16.04.2023.
//

import SwiftUI

struct CustomCurveShape: Shape {
    var xAxis: CGFloat
    var animatableData: CGFloat {
        get { return xAxis }
        set { xAxis = newValue }
    }

    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))

            let center = xAxis + 15
            path.move(to: CGPoint(x: center - 55, y: 0))

            let to1 = CGPoint(x: center, y: -25)
            let control1 = CGPoint(x: center - 35, y: 0)
            let control2 = CGPoint(x: center - 35, y: -25)

            let to2 = CGPoint(x: center + 55, y: 0)
            let control3 = CGPoint(x: center + 35, y: -25)
            let control4 = CGPoint(x: center + 35, y: 0)

            path.addCurve(to: to1, control1: control1, control2: control2)
            path.addCurve(to: to2, control1: control3, control2: control4)
        }
    }
}
