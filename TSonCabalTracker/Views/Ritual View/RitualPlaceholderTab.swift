//
//  RitualPlaceholderTab.swift
//  TSonCabalTracker
//
//  Created by John Moyer on 8/9/24.
//

import SwiftUI

struct RitualPlaceholderTab: View {
    
    @State var item: RitualClass
    @EnvironmentObject var ritualListViewModel: RitualListViewModel
    
    var body: some View {
        ZStack {
//            RoundedRectangle(cornerRadius: 10.0)
//                .frame(maxWidth: .infinity)
//                .foregroundStyle(Color.gray)
            
            HStack {
                Text("\(item.ritual.ritual)")
                    .font(.title3)
                    .foregroundStyle(Color.white)
                    .bold()
                    .shadow(color: Color.black, radius: 15, y: 5)
                    .padding(.horizontal)
                
                Spacer()
                
                Image(systemName: "xmark.diamond.fill")
                    .foregroundStyle(Color.white)
                    .shadow(color: .black, radius: 15, y: 5)
                    .padding(.horizontal)
            }
            .padding()
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .background(Color.gray)
            .cornerRadius(10.0)
        }
    }
}

//#Preview {
//    RitualPlaceholderTab()
//}
