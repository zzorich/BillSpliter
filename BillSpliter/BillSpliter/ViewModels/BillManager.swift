//
//  ViewModel.swift
//  BillSpliter
//
//  Created by lingji zhou on 8/30/24.
//

import Foundation
import Observation
import SwiftData

@Model
class BillManager {
    @Attribute(.unique) let name: String = "Lingji and HaoXin's team"
    var team: SpliterTeam
    func add(group: BillsGroup) {
        if Set(team.billGroups.map({ billGroup in
            billGroup.id
        })).contains(group.id) {
            fatalError()
        }
        team.billGroups.append(group)
    }

    init(team: SpliterTeam = .init()) {
        self.team = team
    }
}


extension BillsGroup {
    var isValid: Bool {
        return !label.isEmpty
    }
}


