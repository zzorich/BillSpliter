//
//  AddBillGroupView.swift
//  BillSpliter
//
//  Created by lingji zhou on 9/1/24.
//

import SwiftUI
import SwiftData

struct EditingBillGroupView: View {
    enum Field: String, Identifiable {
        case label, notes
        var id: String { rawValue }
    }
    @Bindable var billGroup: BillsGroup

    @Environment(\.dismiss) private var dismiss
    @Environment(BillManager.self) private var billManager
    @FocusState private var focusedState: Field?

    @ViewBuilder
    var groupHeader: some View {
        HStack {
            Text("Label")
            TextField("Group Name", text: $billGroup.label)
                .focused($focusedState, equals: .label)
                .multilineTextAlignment(.trailing)

        }
        HStack {
            Text("Notes")
            TextField("Group Description", text: $billGroup.notes)
                .focused($focusedState, equals: .notes)
                .multilineTextAlignment(.trailing)

        }
    }

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("Save") {
                    withAnimation {
                        focusedState = nil
                    } completion: {
                        dismiss()
                    }

                }
                .tint(.mint)
                .padding()
            }
            List {
                Section {
                    groupHeader
                }
//                ForEach(billGroup.bills) { (bill: Bill) in
//                    Section {
//                        DisclosureGroup {
//                            ForEach(bill.transcations) { transcation in
//                                TranscationForum(transcation: transcation)
//                                    .background(content: {
//                                        RoundedRectangle(cornerRadius: 10)
//                                            .stroke(LinearGradient.allGradient.first!)
//                                    })
//                                    .padding([.top, .bottom, .trailing])
//                                    .listRowInsets(EdgeInsets())
//
//                            }
//                            .onDelete { indexSet in
//                                billGroup.deleteTranscations(of: indexSet, in: bill)
//                            }
//
//                            Button {
//                                withAnimation {
//                                    billGroup.add(transcation: .newTemplate, in: bill)
//                                }
//                            } label: {
//                                Label("Add more", systemImage: "plus.circle")
//                            }
//                            .foregroundStyle(.mint)
//                            .padding()
//                            .deleteDisabled(true)
//                        } label: {
//                            @Bindable var bindableBill = bill
//                            TextField("Label", text: $bindableBill.label)
//                                .textFieldStyle(.roundedBorder)
//                                .textContentType(.nickname)
//                                .font(.title3)
//                                .frame(width: 100)
//
//                        }
//
//                    }
//                }
//                .onDelete(perform: billGroup.deleteBills(of:))
            }
            Button {
                withAnimation {
                    billGroup.add(bill: .newTemplate)
                }
            } label: {
                Image(systemName: "plus.circle")
                    .resizable()
                    .scaledToFit()
            }
            .foregroundStyle(.mint)
            .frame(width: 50, height: 25)
            .padding()
            .background(content: {
                RoundedRectangle(cornerRadius: 10)
                    .fill(LinearGradient.allGradient.first!)
            })
        }
    }
}


