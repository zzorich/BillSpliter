//
//  SpliterTeam.swift
//  BillSpliter
//
//  Created by lingji zhou on 8/30/24.
//

import Foundation
import SwiftData

struct Spliter: Hashable, Codable, Identifiable {
    let userName: String
    let userID: String
    var id: String { userID }
}

extension Spliter {
    static let defaultSpliters: [Spliter] = [.haoxin, .lingji]
    static let haoxin: Self = .init(userName: "HaoXin", userID: "user_haoxin")
    static let lingji: Self = .init(userName: "Lingji", userID: "user_lingji")
}

@Model
final class SpliterTeam {
    internal init(id: String = generateNewId(), notes: String = "", name: String = "HaoXin and Lingji's Team", teamMember: [Spliter] = Spliter.defaultSpliters, billGroups: [BillsGroup] = .init(), creationDate: Date = .now) {
        self.id = id
        self.notes = notes
        self.name = name
        self.teamMember = teamMember
        self.billGroups = billGroups
        self.creationDate = creationDate
    }
    
    static func generateNewId() -> String  {
        let id = "team_\(UUID().uuidString)"
        return id
    }

    var id: String = generateNewId()
    var notes: String
    var name: String
    var teamMember: [Spliter]
    var billGroups: [BillsGroup]
    var creationDate: Date
}

@Model
final class BillsGroup: Hashable, Identifiable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    internal init(id: String = generateNewId(), label: String = "New Bill Group", notes: String = "", bills: [Bill] = []) {
        self.id = id
        self.label = label
        self.notes = notes
        self.bills = bills
    }
    
    static func == (lhs: BillsGroup, rhs: BillsGroup) -> Bool {
        lhs.id == rhs.id
    }
    
    static func generateNewId() -> String  {
        let id = "bill_\(UUID().uuidString)"
        return id
    }

    var id: String
    var label: String
    var notes: String
    var bills: [Bill]
    


}

extension BillsGroup {
    static var newTemplate: BillsGroup {
        return BillsGroup.init()
    }
}

@Model
final class Bill: Hashable, Identifiable {
    internal init(date: Date = .now, id: String = generateNewId(), label: String = "New Bill", transcations: [Transcation] = .init()) {
        self.date = date
        self.id = id
        self.label = label
        self.transcations = transcations
    }

    static func generateNewId() -> String  {
        let id = "bill_\(UUID().uuidString)"
        return id
    }
    var date: Date
    var id: String
    var label: String
    var transcations: [Transcation]
}


extension Bill {
    static var newTemplate: Self {
        .init()
    }
}

@Model
final class Transcation: Hashable, Identifiable {
    internal init(splitStrategy: Transcation.SplitingStrategy = .equallySplitted, id: String = generateNewId(), notes: String = "", label: String = "New Transcation", money: Double = .zero, currency: Transcation.Currency = .USD, taxRate: Double = 0.0) {
        self.splitStrategy = splitStrategy
        self.id = id
        self.notes = notes
        self.label = label
        self.money = money
        self.currency = currency
        self.taxRate = taxRate
    }
    
    static let taxRate: Double = 0.1
    var splitStrategy: SplitingStrategy
    static func generateNewId() -> String  {
        let id = "transcation_\(UUID().uuidString)"
        return id
    }
    var id: String
    var notes: String
    var label: String
    var money: Double
    enum SplitingStrategy: Codable, Hashable {
        case equallySplitted
        case custom(haoxinAmount: Double, lingjiAmount: Double)
    }
    var currency: Currency
    enum Currency: String, CaseIterable, Identifiable, Codable {
        case USD = "$"
        case CNY = "¥"
        var id: String { self.rawValue }
    }
    var taxRate = 0.0
}

extension Transcation {
    static var newTemplate: Transcation { .init() }
}


