//
//  SettingsView.swift
//  TSonCabalTracker
//
//  Created by John Moyer on 3/23/24.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    @EnvironmentObject var ritualViewModel: RitualListViewModel
    @State private var isShowingDeleteConfirm = false
    
    var body: some View {
        List {
            Section(header:Text("Settings")){
                Button(action: {
                    isShowingDeleteConfirm = true
                }, label: {
                    Label("Clear Army List", systemImage: "trash.fill")
                        .foregroundStyle(Color.red)
                })
                .confirmationDialog("Start a new army?", isPresented: $isShowingDeleteConfirm, titleVisibility: .visible) {
                    Button("All is Dust", role: .destructive) {
                        listViewModel.clearArmy()
                        ritualViewModel.newGame()
                    }
                }
            }
//            Section(header:Text("About this App")) {
//                Text("About")
//                NavigationLink(destination: WhyNoAdsView(), label:{
//                    Text("No Ads?")
//                })
//            }
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView()
            .environmentObject(ListViewModel())
            .environmentObject(RitualListViewModel())
    }
}
