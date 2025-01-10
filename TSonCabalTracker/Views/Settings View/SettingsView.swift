//
//  SettingsView.swift
//  TSonCabalTracker
//
//  Created by John Moyer on 3/23/24.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var listVM: ListViewModel
    @EnvironmentObject var ritualVM: RitualListViewModel
    @State private var isShowingDeleteConfirm = false
    @State var codexVersion: CodexVersionEnum = CodexVersionEnum.data0624
    
//    func gimmeCodex() -> CodexVersionEnum {
//        switch codexVersion {
//        case .tenth:
//            <#code#>
//        case .data0624:
//            <#code#>
//        }
//    }
    
    var body: some View {
        List {
            Section(header:Text("Settings")){
                
//                Picker("Codex Version", selection: $codexVersion) {
//                    ForEach(CodexVersionEnum.allCases) { item in
//                        Text("\(item.rawValue)")
//                    }
//                }
                
                Button(action: {
                    BottomBarViewer().userOnboarded = false
                }, label: {
                    Label("Reset Onboarding", systemImage: "arrow.triangle.2.circlepath")
                })
                
                Button(action: {
                    isShowingDeleteConfirm = true
                }, label: {
                    Label("Clear Army List", systemImage: "trash.fill")
                        .foregroundStyle(Color.red)
                })
                .confirmationDialog("Start a new army?", isPresented: $isShowingDeleteConfirm, titleVisibility: .visible) {
                    Button("All is Dust", role: .destructive) {
                        listVM.clearArmy()
                        ritualVM.newGame()
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
