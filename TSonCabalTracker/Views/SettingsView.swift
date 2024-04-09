//
//  SettingsView.swift
//  TSonCabalTracker
//
//  Created by John Moyer on 3/23/24.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    @State private var isShowingDeleteConfirm = false
    
    var body: some View {
        List {
            //MUST ADD ARE YOU SURE PROMPT
            Button(action: {
//                listViewModel.clearArmy()
                    isShowingDeleteConfirm = true
            }, label: {
                Label("Clear Army List", systemImage: "trash.fill")
                    .foregroundStyle(Color.red)
            })
            .confirmationDialog("Start a new army?", isPresented: $isShowingDeleteConfirm, titleVisibility: .visible) {
                Button("All is Dust", role: .destructive) {
                    listViewModel.clearArmy()
                }
            }
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(ListViewModel())
}
