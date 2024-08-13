//
//  RitualItemView.swift
//  TSonCabalTracker
//
//  Created by John Moyer on 2/27/23.
//

import SwiftUI

struct RitualItemView: View {
    
    @State var item: RitualClass
    @EnvironmentObject var ritualListViewModel: RitualListViewModel
    
    var body: some View {
        ZStack {
            if item.doubleTap {
                RoundedRectangle(cornerRadius: 10)
                    .frame(maxWidth: 300, maxHeight: 300)
                    .foregroundStyle(Color.darkerGrayer)
                    .offset(x: -20, y: -20)
                    .padding()
            }
            VStack {
                HStack {
                    Text(item.doubleTap ? "\(item.ritual.ritual) x2" : item.ritual.ritual)
                        .font(.title3)
                        .padding()
                        .foregroundStyle(item.status == .freebie ? Color.gaussRifle : item.status == .active ? Color.white : Color.yellow)
                        .shadow(color: Color.white, radius: 15, y: 5)
                        .fontWeight(Font.Weight.bold)
                    
                    
                    Spacer()
                    
                    Text("\(item.ritual.cost)")
                        .multilineTextAlignment(.trailing)
                        .italic()
                        .padding()
                        .bold()
                        .foregroundStyle(item.status == .freebie ? Color.gaussRifle : item.status == .active ? Color.white : Color.yellow)
                }
                
                Text(item.ritual.description)
                    .font(.subheadline)
                    .padding()
                    .foregroundStyle(item.status == .freebie ? Color.white : item.status == .active ? Color.black : Color.white)
            }
            .frame(maxWidth: .infinity)
            .background(item.status == .freebie ? Color.screamerPink : item.status == .active ? Color.gray : Color.indigo)
            .cornerRadius(10)
            .padding()
        }
    }
}



//struct RitualItemView_Previews: PreviewProvider {
//    let ritualPreview = RitualModel(ritual: "ZAP HIM", cost: 69, description: "Get him good with a big zappy zap. hehe hoho")
//    let item = RitualClass(ritual: item, identification: 1)
//    
//    static var previews: some View {
//        RitualItemView(item: item)
//    }
////    .environmentObject(RitualListViewModel())
//}
