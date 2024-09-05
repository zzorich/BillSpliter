//
//  BillsDistributionCharts.swift
//  BillSpliter
//
//  Created by lingji zhou on 9/2/24.
//

import SwiftUI
import Charts

struct BillsDistributionCharts: View {
    let transcations: [Transcation]
    let showAnoation: Bool
    init(transcations: [Transcation], showAnoation: Bool = true) {
        self.transcations = transcations
        self.showAnoation = showAnoation
    }

    private var distributions: [Spliter: Double] {
        transcations.reduce(into: [Spliter: Double]()) { partialResult, transcation in
            switch transcation.splitStrategy {
            case .equallySplitted:
                let spliters = Spliter.defaultSpliters
                spliters.forEach { spliter in
                    partialResult[spliter, default: .zero] += (transcation.money / Double(spliters.count)) * (1 + transcation.taxRate)
                }
            case .custom(haoxinAmount: let haoxinAmount, lingjiAmount: let lingjiAmount):
                partialResult[.haoxin, default: .zero] += haoxinAmount * (1 + transcation.taxRate)
                partialResult[.lingji, default: .zero] += lingjiAmount * (1 + transcation.taxRate)
            }
        }
    }

    var body: some View {
        let distributions = self.distributions
        Chart(Spliter.defaultSpliters) { spliter in
            let money = distributions[spliter, default: .zero]
            SectorMark(
                angle: .value("Spending", money),
                angularInset: 1
            )
            .annotation(position: .overlay) {
                Text("\(distributions[spliter, default: .zero].formatted(.currency(code: "USD")))")
                    .padding()
                    .opacity(showAnoation ? 1.0 : 0)
            }
            .cornerRadius(3.0)
            .foregroundStyle(by: .value("Name", spliter.userName))
        }
    }
}

