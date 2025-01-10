//
//  LoadingView.swift
//  TSonCabalTracker
//
//  Created by John Moyer on 1/7/25.
//

import SwiftUI

struct AppIcon: View {
    var body: some View {
        Bundle.main.iconFileName
            .flatMap { UIImage(named: $0) }
            .map { Image(uiImage: $0) }
    }
}

struct LoadingView: View {
    
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(Color.screamerPink)
                .ignoresSafeArea()
            VStack {
                AppIcon()
                Text("Tizcan Abacus")
                    .font(Font.custom("Cochin Bold", size: 30))
                    .foregroundStyle(Color.gaussRifle)
                    .shadow(color: Color.darkerGrayer ,radius: 10)
            }
        }
        .onAppear {
            withAnimation(.easeIn) {
                isPresented.toggle() 
            }
        }
    }
}

extension Bundle {
    var iconFileName: String? {
        guard let icons = infoDictionary?["CFBundleIcons"] as? [String: Any],
              let primaryIcon = icons["CFBundlePrimaryIcon"] as? [String: Any],
              let iconFiles = primaryIcon["CFBundleIconFiles"] as? [String],
              let iconFileName = iconFiles.last
        else { return nil }
        return iconFileName
    }
}

#Preview {
    LoadingView(isPresented: .constant(true))
}
