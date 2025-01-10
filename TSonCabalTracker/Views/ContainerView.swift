//
//  ContainerView.swift
//  TSonCabalTracker
//
//  Created by John Moyer on 1/9/25.
//

import SwiftUI

struct ContainerView: View {
    
    @State private var isSplashScreenPresented = true
    
    var body: some View {
        if !isSplashScreenPresented {
            BottomBarViewer()
        } else {
            LoadingView(isPresented: $isSplashScreenPresented)
        }
    }
}

#Preview {
    ContainerView()
        .environmentObject(ListViewModel())
        .environmentObject(RitualListViewModel())
}
