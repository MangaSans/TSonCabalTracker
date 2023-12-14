//
//  RitualItemView.swift
//  TSonCabalTracker
//
//  Created by John Moyer on 2/27/23.
//

import SwiftUI

struct RitualItemView: View {
    
    let item: RitualModel
    
    var body: some View {
//        Form {
            VStack {
                HStack {
//                    Text("ZAP HIM")
                    Text(item.ritual)
                        .font(.title3)
                        .padding()
                        .foregroundColor(Color.accentColor)
                        .shadow(color: Color.white, radius: 15, y: 5)
                        .fontWeight(Font.Weight.bold)
                    Spacer()
//                    Text("Cost: 4")
                    Text("\(item.cost)")
                        .multilineTextAlignment(.trailing)
                        .italic()
                        .padding()
                        .foregroundColor(Color.white)
                        .bold()
                }
                
//                Divider()
//                Text("Get him good with a big zappy zap. hehe hoho")
                Text(item.description)
                    .font(.subheadline)
                    .padding()
                
            }
            .frame(maxWidth: .infinity)
            .background(Color.gray)
            .cornerRadius(10)
            .padding()
//        }
    }
}

struct RitualItemView_Previews: PreviewProvider {
    static var item = RitualModel(ritualTitle: "ZAP HIM", ritualCost: 69, ritualDesc: "Get him good with a big zappy zap. hehe hoho")
    
    static var previews: some View {
        RitualItemView(item: item)
    }
}
