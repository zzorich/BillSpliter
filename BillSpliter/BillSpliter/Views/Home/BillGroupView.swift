//
//  BillGroupView.swift
//  BillSpliter
//
//  Created by lingji zhou on 9/1/24.
//

import SwiftUI

struct BillGroupView: View {
    @Namespace private var zoomTransition
    @Environment(Router.self) private var router

    let billGroup: BillsGroup
    var rows: [GridItem] {
        if billGroup.bills.count <= 4 {
            [GridItem(.flexible())]
        } else {
            [GridItem(.flexible()), GridItem(.flexible())]
        }
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: rows) {
                ForEach(billGroup.bills) { bill in
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.thickMaterial)
                        VStack {
                            Text(bill.label)
                            if bill.transcations.isEmpty {
                                Text("Add more transcation")
                                    .font(.footnote)
                            } else {
                                BillsDistributionCharts(transcations: bill.transcations, showAnoation: false)
                            }
                        }
                    }
                    .frame(width: 100, height: 100)
                    .onTapGesture {
                        router.navigate(to: .billDetail(bill: bill))
                    }
                }
            }
            .scrollTargetLayout()
            .frame(height: billGroup.bills.count > 4 ? 300 : 150)
        }
        .scrollTargetBehavior(.viewAligned)
    }
}
