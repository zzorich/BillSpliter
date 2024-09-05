//
//  Color.swift
//  BillSpliter
//
//  Created by lingji zhou on 8/30/24.
//

import Foundation
import SwiftUI

extension Color {
    static func randomColor() -> Self {
        let red = Double.random(in: 0...1)
        let green = Double.random(in: 0...1)
        let blue = Double.random(in: 0...1)

        return .init(red: red, green: green, blue: blue)
    }
}

extension LinearGradient {
    static let allGradient: [Self] = (0..<100).map { _ in
            .init(colors: [.randomColor(), .randomColor()], startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}
