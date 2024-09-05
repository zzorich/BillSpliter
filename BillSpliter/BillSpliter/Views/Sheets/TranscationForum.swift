//
//  TranscationForum.swift
//  BillSpliter
//
//  Created by lingji zhou on 9/2/24.
//

import SwiftUI

typealias Currency = Transcation.Currency
struct TranscationForum: View {
    @Bindable var transcation: Transcation
    var body: some View {

        VStack {
            HStack {
                Text("Label")
                    .foregroundStyle(.primary)
                Divider()
                TextField("Enter Label", text: $transcation.label)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.trailing)
            }
            .padding([.leading, .trailing, .top])

            Capsule(style: .continuous)
                .foregroundStyle(.secondary)
                .frame(height: 2)
                .padding([.leading, .trailing])

            HStack {

                Picker("Select Currency", selection: $transcation.currency) {
                    ForEach(Currency.allCases) { currency in
                        Text(currency.rawValue).tag(currency)
                    }
                }
                .pickerStyle(.segmented)
                Divider()
                TextField("Enter amount", value: $transcation.money, formatter: NumberFormatter.currencyFormatter)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad) // Use decimal pad for currency
            }
            .padding([.leading, .trailing])

            Capsule(style: .continuous)
                .foregroundStyle(.secondary)
                .frame(height: 2)
                .padding([.leading, .trailing])
            TextEditor(text: $transcation.notes)
                .cornerRadius(10)
                .frame(height: 100)
                .padding([.leading, .trailing])
        }
    }
}

