//
//  DuplicatePopupView.swift
//  TSonCabalTracker
//
//  Created by John Moyer on 8/4/24.
//

import SwiftUI

struct DuplicatePopupView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundStyle(Color.accentColor.opacity(0.5))
                .frame(maxWidth: 220,maxHeight: 100)
            Text("You already have this unit in your list.")
                .foregroundStyle(Color.white)
                .font(.title2)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 200)
                .shadow(radius: 20)
            
        }
    }
}

#Preview {
    DuplicatePopupView()
}
