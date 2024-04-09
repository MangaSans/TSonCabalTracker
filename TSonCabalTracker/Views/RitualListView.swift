//
//  RitualListView.swift
//  TSonCabalTracker
//
//  Created by John Moyer on 2/26/23.
//

import SwiftUI

struct RitualListView: View {
    
    @EnvironmentObject var ritualListViewModel: RitualListViewModel
    @EnvironmentObject var listViewModel: ListViewModel
    
    var body: some View {
//        NavigationView {
            VStack {
                HStack {
                    VStack {
                        HStack {
                            Text("Cabal Points: ")
                                .font(.headline)
                                .foregroundColor(.accentColor)
                            Text(listViewModel.cabalBonusPoints > 0 ?
                                 "\(listViewModel.cabalTotalPoints) + \(listViewModel.cabalBonusPoints)"
                                 : "\(listViewModel.cabalTotalPoints)")
                            .font(.headline)
                        }
                        HStack {
                            Text("Ritual Cost: ")
                                .font(.headline)
                                .foregroundColor(.accentColor)
                            Text("\(ritualListViewModel.ritualCostTotal)")
                        }
                        .padding()
                    }
                    ZStack {
                        
                        Button(action: {
//                            ritualListViewModel.newTurn()
                        }, label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                                Text("Reset")
                                    .bold()
                                    .foregroundStyle(Color.white)
                            }
                            
                        })
                    }
                }
                List {
                    ForEach(ritualListViewModel.rituals, id: \.self) { item in
                        RitualItemView(item: item)
                            .onTapGesture {
//                                ritualListViewModel.selectedRitual(item: item)
                            }
                    }
                }
                .padding(.bottom)
            }
//        }
//        .navigationTitle("Cabalistic Rituals")
    }
}

struct CabalListView_Previews: PreviewProvider {
    static var previews: some View {
//        NavigationStack {
            RitualListView()
//        }
        .environmentObject(RitualListViewModel())
        .environmentObject(ListViewModel())
    }
}
