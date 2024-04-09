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
//    @State var ded: Bool
//    @State var nickname: String?
    @State var unitCheck: String?
    
    
//    init(item: UnitData) {
//        self.item = item
//////        nickname = item.nickname ?? "???"
////        if let unitType = item.unitType {
////            
////        }
////        
////        ded = item.isAlive
//        
//    }
    
    var body: some View {
        if (item.unitType != nil) {
            ZStack {
//                RoundedRectangle(cornerRadius: 45.0)
//                    .stroke(Color.accentColor, lineWidth: 2)
                HStack {
                    Text(item.isAlive ? "😎" : "💀")
                    Text(item.nickname == nil ?
                         "\(item.unitType!)" : "\(item.nickname!) (\(item.unitType!))")
                    Spacer()
                    item.isAlive ? Text("\(item.pointValue) Points") : Text("\(item.pointValue) Points").strikethrough()
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
