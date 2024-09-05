//
//  ContentView.swift
//  BillSpliter
//
//  Created by lingji zhou on 8/30/24.
//

import SwiftUI
import SwiftData

struct RootView: View {
    @State private var homeRouter: Router = .init()
    @State private var summaryRouter: Router = .init()
    @State private var tabRouter: Router = .init()

    @Query var billManagers: [BillManager]

    @Environment(\.modelContext) private var modelContext

    private var billManager: BillManager {
        guard billManagers.isEmpty else { return billManagers.first! }
        let newBillManager: BillManager = .init()
        modelContext.insert(newBillManager)
        return newBillManager
    }

    var body: some View {
        TabView(selection: $tabRouter.tab) {
            NavigationStack(path: $homeRouter.path) {
                HomeView()
                    .routable()
            }
            .environment(homeRouter)
            .tabItem {
                Label("Home", systemImage: "list.bullet.circle.fill")
            }.tag(Router.Tab.home)


            Text("Summary").tag(Router.Tab.summary)
                .environment(summaryRouter)
        }
        .environment(billManager)
    }
}

#Preview {
    RootView()
}
