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
    
    //var to check for first time launch
    @AppStorage("userOnboarded") var userOnboarded: Bool = false
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        var _: () = print("User is onboarded?", userOnboarded)

        ZStack {
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
            .opacity(userOnboarded ? 1.0 : 0.25)
            
            if (!userOnboarded){
                OnBoardingView()
                    .frame(maxHeight: .infinity)
                    .background(colorScheme == .light ? Color.gray.opacity(0.75) : Color.black.opacity(0.75))
                    .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                    .animation(.easeInOut, value: userOnboarded)
            }
        }
    }
}

#Preview {
    BottomBarViewer()
        .environmentObject(ListViewModel())
        .environmentObject(RitualListViewModel())
}
