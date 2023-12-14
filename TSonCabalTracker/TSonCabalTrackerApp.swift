//
//  TSonCabalTrackerApp.swift
//  TSonCabalTracker
//
//  Created by John Moyer on 2/24/23.
//

import SwiftUI

@main
struct TSonCabalTrackerApp: App {
    
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    @StateObject var ritualViewModel: RitualListViewModel = RitualListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ListView()
            }
            .environmentObject(listViewModel)
            .environmentObject(ritualViewModel)
        }
    }
}
