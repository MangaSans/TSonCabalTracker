//
//  AboutView.swift
//  TSonCabalTracker
//
//  Created by John Moyer on 5/5/24.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        NavigationStack {
            Text("Tizcan Abacus")
                .fontWeight(.heavy)
            Text("Version: ")
        }
    }
}

#Preview {
    NavigationStack {
        AboutView()
    }
}
