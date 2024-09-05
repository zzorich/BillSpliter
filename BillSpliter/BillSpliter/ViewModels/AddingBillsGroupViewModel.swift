//
//  AddingBillsGroupViewModel.swift
//  BillSpliter
//
//  Created by lingji zhou on 9/1/24.
//

import Foundation


extension BillsGroup {

    func add(transcation: Transcation, in bill: Bill) {
        guard let index = self.bills.firstIndex(of: bill) else { return }
        self.bills[index].transcations.append(transcation)
    }

    func deleteTranscations(of indexSet: IndexSet, in bill: Bill) {
        guard let index = self.bills.firstIndex(of: bill) else { return }
        self.bills[index].transcations.remove(atOffsets: indexSet)
    }

    func deleteBills(of indexSet: IndexSet) {
        self.bills.remove(atOffsets: indexSet)
    }

    func add(bill: Bill) {
        self.bills.append(bill)
    }
}
