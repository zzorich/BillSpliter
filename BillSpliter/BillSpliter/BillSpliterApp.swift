//
//  BillSpliterApp.swift
//  BillSpliter
//
//  Created by lingji zhou on 8/30/24.
//

import SwiftUI
import SwiftData

@main
struct BillSpliterApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(for: BillManager.self)
    }
}
