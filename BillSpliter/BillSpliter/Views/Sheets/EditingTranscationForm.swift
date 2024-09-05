//
//  EditingTranscationForm.swift
//  BillSpliter
//
//  Created by lingji zhou on 9/3/24.
//

import SwiftUI

struct EditingTranscationForm: View {
    @Environment(Router.self) private var router
    @Bindable var transcation: Transcation
    @State private var isEqualSplit: Bool = true
    @State private var label: String = ""
    @State private var notes: String = ""
    @State private var totalAmount: Double = .zero
    @State private var lingjiAmount: Double = .zero
    @State private var haoxinAmount: Double = .zero
    @State private var needTax: Bool = false
    @State private var taxRate: Double = 0.0
    @State private var currency: Currency = .USD
    var body: some View {
        Form {
            Section {
                HStack {
                    Text("Label")
                    Divider()
                    TextField("label", text: $label)
                        .multilineTextAlignment(.trailing)
                }
                HStack {

                    Picker("Select Currency", selection: $currency) {
                        ForEach(Currency.allCases) { currency in
                            Text(currency.rawValue).tag(currency)
                        }
                    }
                    .pickerStyle(.segmented)
                    TextField("Enter amount", value: $totalAmount, formatter: NumberFormatter.currencyFormatter)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad) // Use decimal pad for currency
                }
                Toggle("Split Equally?", isOn: $isEqualSplit)

                if !isEqualSplit {
                    HStack {
                        Text("Lingji")
                        TextField("Enter amount", value: $lingjiAmount, formatter: NumberFormatter.currencyFormatter)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.decimalPad)
                    }
                    HStack {
                        Text("HaoXin")
                        TextField("Enter amount", value: $haoxinAmount, formatter: NumberFormatter.currencyFormatter)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.decimalPad)
                    }
                }

                Toggle("Need Tax?", isOn: $needTax)
                if needTax {
                    HStack {
                        Text("tax rate")
                        TextField("Enter amount", value: $taxRate, formatter: NumberFormatter.currencyFormatter)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.decimalPad)
                    }
                }
            }
            Section("notes") {
                TextEditor(text: $notes)
            }
        }
        .onAppear(perform: {
            label = transcation.label
            notes = transcation.notes
            needTax = transcation.taxRate > 0.001
            switch transcation.splitStrategy {
            case .equallySplitted:
                isEqualSplit = true
                totalAmount = transcation.money
                haoxinAmount = totalAmount / 2.0
                lingjiAmount = totalAmount / 2.0
            case .custom(let haoxinAmount, let lingjiAmount):
                isEqualSplit = false
                totalAmount = haoxinAmount + lingjiAmount
                self.haoxinAmount = haoxinAmount
                self.lingjiAmount = lingjiAmount
            }
        })
        .onChange(of: lingjiAmount) { oldValue, newValue in
            totalAmount = newValue + haoxinAmount
        }
        .onChange(of: haoxinAmount) { oldValue, newValue in
            totalAmount = newValue + lingjiAmount
        }
        .onChange(of: isEqualSplit) { oldValue, newValue in
            haoxinAmount = totalAmount / 2.0
            lingjiAmount = totalAmount / 2.0
        }
        .onChange(of: needTax) { oldValue, newValue in
            if newValue == false {
                taxRate = 0.0
            }
        }
        .animation(.spring(), value: isEqualSplit)
        .animation(.spring(), value: needTax)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    transcation.money = totalAmount
                    transcation.label = label
                    transcation.notes = notes
                    transcation.splitStrategy = if isEqualSplit {
                        Transcation.SplitingStrategy.equallySplitted
                    } else {
                        Transcation.SplitingStrategy.custom(haoxinAmount: haoxinAmount, lingjiAmount: lingjiAmount)
                    }
                    transcation.taxRate = taxRate
                    transcation.currency = currency

                    router.pop()
                }
            }
        }
    }
}

