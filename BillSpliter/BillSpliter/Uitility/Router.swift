//
//  File.swift
//  BillSpliter
//
//  Created by lingji zhou on 8/31/24.
//

import Foundation
import SwiftUI

private var sharedNamespace: Namespace.ID? = nil
extension View {
    func routable() -> some View {
        self.navigationDestination(for: Router.Route.self) { route in
            Router.Route.view(for: route, namespace: sharedNamespace)
        }
    }
}

@Observable
class Router {
    @ObservationIgnored var namespace: Namespace.ID? = nil

    enum Tab: String, Hashable {
        case home, summary
    }
    enum Route: Hashable {
        static func == (lhs: Router.Route, rhs: Router.Route) -> Bool {
            switch (lhs, rhs) {
            case (.billDetail(bill: let lbill), .billDetail(bill: let rbill)):
                return lbill.id == rbill.id
            case (.billGroupDetail(billGroup: let lbillGroup), .billGroupDetail(billGroup: let rbillGroup)):
                return lbillGroup.id == rbillGroup.id
            case (.transcationEditingForm(transcation: let ltranscation), .transcationEditingForm(transcation: let rtranscation)):
                return ltranscation.id == rtranscation.id
            default:
                return false
            }
        }
        
        func hash(into hasher: inout Hasher) {
            switch self {
            case .billGroupDetail(let billGroup):
                hasher.combine(billGroup.id)
            case .billDetail(let bill):
                hasher.combine(bill.id)
            case .transcationEditingForm(let transcation):
                hasher.combine(transcation.id)
            }
        }
        case billGroupDetail(billGroup: BillsGroup)
        case billDetail(bill: Bill)
        case transcationEditingForm(transcation: Transcation)

        @ViewBuilder
        static func view(for route: Route, namespace: Namespace.ID? = nil) -> some View {
            switch route {
            case .billGroupDetail(let billGroup):
                BillGroupDetailView(billGroup: billGroup)
            case .billDetail(let bill):
                BillDetailView(bill: bill)
            case .transcationEditingForm(transcation: let transcation):
                EditingTranscationForm(transcation: transcation)
            }
        }
    }

    var path: NavigationPath = .init()
    var tab: Tab = .home

    func navigate(to route: Route, namespace: Namespace.ID? = nil) {
        sharedNamespace = namespace
        path.append(route)
    }

    func pop() {
        path.removeLast()
    }
}
