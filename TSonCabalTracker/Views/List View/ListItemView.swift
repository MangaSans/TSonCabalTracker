//
//  ListItemView.swift
//  TSonCabalTracker
//
//  Created by John Moyer on 2/24/23.
//

import SwiftUI
import CoreData

struct ListItemView: View {
    
    @ObservedObject var item: UnitData
    @State var unitCheck: String?
    
    var body: some View {
        if (item.unitType != nil) {
            ZStack {
                HStack {
                    Text(item.isAlive ? "😎" : "💀")
                    Text(item.scrollHolder ? "🧻" : "")
                    Text(item.loreHolder ? "🧙‍♂️" : "")
                    Text(item.nickname == nil ?
                         "\(item.unitType!)" : "\(item.nickname!) (\(item.unitType!))")
                    Spacer()
                    if item.scrollHolder {
                        item.isAlive ? Text("\(item.pointValue + 1) Points") : Text("\(item.pointValue + 1) Points").strikethrough()
                    } else {
                        item.isAlive ? Text("\(item.pointValue) Points") : Text("\(item.pointValue) Points").strikethrough()
                    }
                    
                }
                .padding()
            }
        }
    }
}

//struct ListItemView_Previews: PreviewProvider {
//    static var item = UnitData()
//    
//    static var previews: some View {
//        ListItemView(item: item)
//    }
//}
