//
//  SwiftUIView.swift
//  BillSpliter
//
//  Created by lingji zhou on 9/2/24.
//

import SwiftUI

struct BillDetailView: View {
    let bill: Bill
    var body: some View {
        VStack(alignment: .leading) {
            Text(bill.label)
                .font(.title)
            Text("Total Spending")
                .font(.subheadline)
            BillsDistributionCharts(transcations: bill.transcations)
            .frame(width: 200, height: 200)
            .frame(maxWidth: .infinity)

            List {
                ForEach(bill.transcations) { transcation in
                    HStack {
                        Text(transcation.label)
                        Spacer()
                        Text(transcation.money.formatted(.currency(code: "USD")))
                    }
                }
            }
        }
        .padding()
    }
}

