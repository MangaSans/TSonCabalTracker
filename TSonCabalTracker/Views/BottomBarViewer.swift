//
//  TabView.swift
//  TSonCabalTracker
//
//  Created by John Moyer on 3/3/24.
//

import SwiftUI

struct BottomBarViewer: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    @EnvironmentObject var ritualListViewModel: RitualListViewModel
    
    var body: some View {
        TabView {
            NavigationStack {
                ListView()
            }
            .tabItem { Label("Army List", systemImage: "person.3.sequence") }
            
            RitualListView()
                .tabItem { Label("Ritual List", systemImage: "scroll") }
            
            SettingsView()
                .tabItem { Label("Settings", systemImage: "gearshape.2") }
        }
//        .tabViewStyle(<#T##style: TabViewStyle##TabViewStyle#>)
    }
}

#Preview {
    BottomBarViewer()
        .environmentObject(ListViewModel())
        .environmentObject(RitualListViewModel())
}
