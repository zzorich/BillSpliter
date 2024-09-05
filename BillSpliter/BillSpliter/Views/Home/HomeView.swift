//
//  HomeView.swift
//  BillSpliter
//
//  Created by lingji zhou on 8/31/24.
//

import SwiftUI

struct BillGroupHeaderView: View {
    let billGroup: BillsGroup
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(billGroup.label)
                    .foregroundStyle(.primary)
                    .font(.title2)
                Text(billGroup.notes)
                    .foregroundStyle(.secondary)
                    .font(.footnote)
            }
            Spacer()
            if (billGroup.bills.isEmpty) {
                Button {

                } label: {
                    Image(systemName: "plus.rectangle.fill")
                }
            }

        }
    }
}
struct HomeView: View {
    @Environment(BillManager.self) private var billManager: BillManager
    @State private var templateGroup: BillsGroup = .newTemplate
    @State private var isAddingGroup: Bool = false
    @Environment(Router.self) private var router
    var body: some View {
        ScrollViewReader { proxy in
            List {
                ForEach(billManager.team.billGroups) { billGroup in
                    Section {
                        VStack(alignment: .leading) {
                            BillGroupHeaderView(billGroup: billGroup)
                            if (!billGroup.bills.isEmpty) {
                                BillGroupView(billGroup: billGroup)
                            }
                        }
                        .onTapGesture {
                            router.navigate(to: .billGroupDetail(billGroup: billGroup))
                        }
                        .padding(.all, 10.0)
                        .background {
                            LinearGradient.allGradient.randomElement()
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .listRowInsets(EdgeInsets())
                }
                .onDelete(perform: { indexSet in
                    billManager.team.billGroups.remove(atOffsets: indexSet)
                })
            }
            .listStyle(.insetGrouped)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isAddingGroup.toggle()
                        templateGroup = .newTemplate
                    } label: {
                        Label("Add More", systemImage: "plus.app")
                    }
                    .font(.largeTitle)
                    .tint(.mint)
                }
            }
            .navigationTitle("Test")
            .navigationBarTitleDisplayMode(.automatic)
            .background(Color.black)
            .sheet(isPresented: $isAddingGroup) {
                withAnimation {
                    billManager.add(group: templateGroup)
                } completion: {
                    withAnimation {
                        proxy.scrollTo(billManager.team.billGroups.last!.id, anchor: .bottom)
                    }
                }
            } content: {
                EditingBillGroupView(billGroup: templateGroup)
            }
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
            .environment(BillManager())
            .preferredColorScheme(.light)
            .environment(Router())
    }
}
