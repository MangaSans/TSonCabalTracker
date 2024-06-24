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
            VStack {
                Toggle(isOn: $ritualListViewModel.freebieTriggered) {
                    Text("Ahriman's Freebie triggered?")
                        .foregroundStyle(Color.screamerPink)
                        .bold()
                }
                .padding()
            
                HStack {
                    VStack {
                        //CABAL POINT TEXT
                        HStack {
                            Text("Cabal Points: ")
                                .font(.headline)
                                .foregroundColor(.accentColor)
                            Text(listViewModel.cabalBonusPoints > 0 ?
                                 "\(listViewModel.cabalTotalPoints) + \(listViewModel.cabalBonusPoints)"
                                 : "\(listViewModel.cabalTotalPoints)")
                            .font(.headline)
                        }
                        
                        //COST TEXT
                        HStack {
                            Text("Ritual Cost: ")
                                .font(ritualListViewModel.ritualCostTotal > listViewModel.cabalTotalPoints + listViewModel.cabalBonusPoints ?
                                     .headline
                                    .italic() :
                                        .headline
                                    )
                                .foregroundColor(
                                    ritualListViewModel.ritualCostTotal > listViewModel.cabalTotalPoints + listViewModel.cabalBonusPoints ?
                                    Color.red :
                                        .accentColor
                                )
                                
                            Text("\(ritualListViewModel.ritualCostTotal)")
                        }
                        .padding()
                    }
                    
                    //RESET BUTTON
                    ZStack {
                        HStack {
                            Button(action: {
                                ritualListViewModel.newTurn()
                            }, label: {
                                ZStack{
                                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                        .frame(width: 150, height: 100)
                                    Text("Reset")
                                        .bold()
                                        .foregroundStyle(Color.white)
                                }
                                //Why you no long press?
//                                .onLongPressGesture(minimumDuration: 0.5) {
//                                    ritualListViewModel.newGame()
//                                }
                            })
                        }
                    }
                }
                
//              MARK: Actual List
                List {
                    ForEach(ritualListViewModel.ritualClass, id: \.self.ritual.ritual)  { item in
                        ZStack {
                            RitualItemView(item: item)
                                .onTapGesture {
                                    ritualListViewModel.toggle(item: item)
                                    if (item.doubleTap) { item.doubleTap = false }
                                }
                                .swipeActions {
                                    if (listViewModel.ahrimanAlive &&  !ritualListViewModel.freebieTriggered) {
                                        Button("Ahriman") {
                                                ritualListViewModel.toggleFreebie(item: item)
                                        }
                                        .tint(.screamerPink)
                                        
                                    }
                                    if (listViewModel.loreAlive) {
                                        Button("x2") {
                                            if (item.status == .off) {
                                                ritualListViewModel.toggle(item: item)
                                            }
                                            ritualListViewModel.doubleTapToggle(item: item)
                                        }
                                        .tint(Color.accentColor)
                                    }
                            }
                        }
                    }
                }
                .padding(.bottom)
            }
        }
    }


struct CabalListView_Previews: PreviewProvider {
    static var previews: some View {
            RitualListView()
        .environmentObject(RitualListViewModel())
        .environmentObject(ListViewModel())

    }
}
