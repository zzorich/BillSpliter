//
//  Formatter.swift
//  BillSpliter
//
//  Created by lingji zhou on 9/1/24.
//

import Foundation

extension NumberFormatter {
    static let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale.current
        return formatter
    }()
}
