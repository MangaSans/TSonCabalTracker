//
//  ListItemView.swift
//  TSonCabalTracker
//
//  Created by John Moyer on 2/24/23.
//

import SwiftUI

struct ListItemView: View {
    
    let item: UnitModel
    
    var body: some View {
        HStack {
            Text(item.isAlive ? "😎" : "💀")
            Text(item.nickname == nil ?
                 "\(item.title)" : "\(item.nickname!) (\(item.title))")
            Spacer()
            Text("\(item.value) Points")
        }
        .padding()
    }
}

struct ListItemView_Previews: PreviewProvider {
    static var item = UnitModel(title: "Butters", value: 69, nickname: "Bingo")
    
    static var previews: some View {
        ListItemView(item: item)
    }
}
