//
//  ToggleCheckPlainView.swift
//  TSonCabalTracker
//
//  Created by John Moyer on 7/18/24.
//

import SwiftUI

struct CheckToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            Label {
                configuration.label
            } icon: {
                Image(systemName: configuration.isOn ? "bolt.square.fill" : "square")
                    .foregroundStyle(configuration.isOn ? Color.screamerPink : .secondary)
                    .accessibility(label: Text(configuration.isOn ? "Checked" : "Unchecked"))
                    .imageScale(.large)
            }
        }
        .buttonStyle(.plain)
    }
}
