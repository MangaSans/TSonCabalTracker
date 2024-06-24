//
//  TabView.swift
//  TSonCabalTracker
//
//  Created by John Moyer on 3/3/24.
//

import SwiftUI

struct BottomBarViewer: View {
    
    @EnvironmentObject var listVM: ListViewModel
    @EnvironmentObject var ritualVM: RitualListViewModel
    
    var body: some View {
        TabView {
            NavigationStack {
                ListView()
            }
            .tabItem { Label("Army List", systemImage: "person.3.sequence") }
            
            RitualListView()
                .tabItem { Label("Ritual List", systemImage: "scroll") }
            NavigationStack {
                SettingsView()
            }
                .tabItem { Label("Settings", systemImage: "gearshape.2") }
        }
    }
}

#Preview {
    BottomBarViewer()
        .environmentObject(ListViewModel())
        .environmentObject(RitualListViewModel())
}
