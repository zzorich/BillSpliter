//
//  BillGroupDetailView.swift
//  BillSpliter
//
//  Created by lingji zhou on 9/3/24.
//

import SwiftUI

struct BillGroupDetailView: View {
    @Bindable var billGroup: BillsGroup
    @Environment(Router.self) private var router
    @State private var isEditing: Bool = false
    var body: some View {
        VStack(alignment: .leading) {
            Text(billGroup.label)
                .font(.title)
            Text("Total Spending")
                .font(.subheadline)
                BillsDistributionCharts(transcations: billGroup.bills.flatMap({ bill in
                    bill.transcations
                }))
                .frame(width: 200, height: 200)
                .frame(maxWidth: .infinity)


            List {
                ForEach(billGroup.bills) { bill in
                    Section {

                        ForEach(bill.transcations) { transcation in
                            HStack {
                                Text(transcation.label)
                                Spacer()
                                Text(transcation.money.formatted(.currency(code: "USD")))
                                if isEditing {
                                    Button {
                                        router.navigate(to: .transcationEditingForm(transcation: transcation))
                                    } label: {
                                        Image(systemName: "chevron.right")
                                    }
                                }
                            }
                        }
                        .onDelete(perform: { indexSet in
                        })

                        if isEditing {
                            Button("Add New Transcation") {
                                withAnimation {
                                    billGroup.add(transcation: .newTemplate, in: bill)
                                }
                            }
                        }
                    } header: {
                        @Bindable var bindableBill =  bill
                        if isEditing {
                            TextField(text: $bindableBill.label) {
                                Text("Label")
                            }
                        } else {
                            Text(bill.label)
                        }
                    }

                }
            }
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button(isEditing ? "Save" : "Edit") {
                    withAnimation {
                        isEditing.toggle()
                    }
                }
            }

            if isEditing {
                ToolbarItem(placement: .bottomBar) {
                    Button("Add New Bill") {
                        billGroup.add(bill: .newTemplate)
                    }
                }
            }
        }
        .navigationTitle(billGroup.label)
    }
}

