//
//  RitualListView.swift
//  TSonCabalTracker
//
//  Created by John Moyer on 2/26/23.
//

import SwiftUI

struct RitualListView: View {
    
    @EnvironmentObject var ritualVM: RitualListViewModel
    @EnvironmentObject var listVM: ListViewModel
    
    func phaseName(phaseNumber: Int) -> String {
        switch phaseNumber {
        case 0: return "Command"
        case 1: return "Movement"
        case 2: return "Shooting"
        case 3: return "Charge"
        case 4: return "Fighting"
        default: return "Command"
        }
    }
    
    func ahrimanToggle() -> some View {
        Toggle(isOn: $ritualVM.freebieTriggered) {
            Text("Ahriman's Free Cast?")
                .foregroundStyle(Color.screamerPink)
                .bold()
        }
        .toggleStyle(CheckToggleStyle())
    }
                        
    
    func topBar() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0)
                .frame(maxHeight: 40)
                .padding(.horizontal)
                .foregroundColor(.teal)
            
            HStack {
                    Text("\(phaseName(phaseNumber: ritualVM.phaseCounter)) Phase")
                        .font(.title3)
                        .italic()
                        .bold()
                        .foregroundStyle(Color.yellow)
                        .multilineTextAlignment(.trailing)
                        .padding()
                
                
                if (!canAffordTotal()) {
                    HStack {
                        Text("Next Phase?")
                            .font(.title3)
                            .foregroundStyle(Color.red)
                            .bold()
                            .strikethrough()
                        Image(systemName: "xmark.octagon.fill")
                            .foregroundStyle(Color.red)
                            .font(.title3)
                    }
                    .padding()
                } else {
                    Button(action: {ritualVM.nextPhase()}, label: {
                        HStack {
                            Text("Next Phase?")
                                .font(.title3)
                                .foregroundStyle(Color.white)
                                .bold()
                            Image(systemName: "arrowshape.zigzag.right")
                                .foregroundStyle(Color.white)
                                .font(.title3)
                        }
                    })
                    .padding()
                }
            }
        }
    }
    
    func combineCosts() -> Int {
        return ritualVM.ritualCostTotal + ritualVM.ritualCostPhase
    }
    
    func canAffordTotal() -> Bool {
        if (combineCosts() > listVM.cabalTotalPoints + listVM.cabalBonusPoints) {
            return false
        } else {
            return true
        }
    }
    
    var body: some View {
            VStack {
                
                topBar()
                    .padding(.top)
                
                HStack {
                    
                    //RESET BUTTON
                    VStack {
                        ZStack {
                            HStack {
                                Button(action: {
                                    ritualVM.newTurn()
                                }, label: {
                                    ZStack{
                                        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                            .frame(width: 150, height: 100)
                                        VStack{
                                            Text("New Turn")
                                                .bold()
                                                .foregroundStyle(Color.white)
                                            Text("(Turn: \(ritualVM.turnCounter))")
                                                .italic()
                                                .foregroundStyle(Color.yellow)
                                        }
                                    }
                                })
                            }
                        }
                    }
                    
                    VStack {
                        //CABAL POINT TEXT
                        HStack {
                            Text("Cabal Points: ")
                                .font(.headline)
                                .foregroundColor(.accentColor)
                            Text(listVM.cabalBonusPoints > 0 ?
                                 "\(listVM.cabalTotalPoints) + \(listVM.cabalBonusPoints)"
                                 : "\(listVM.cabalTotalPoints)")
                            .font(.headline)
                        }
                        
                        //PHASE COST TEXT
                        HStack {
                            Text("Phase Cost:")
                                .font(combineCosts() > listVM.cabalTotalPoints + listVM.cabalBonusPoints ?
                                    .headline
                                   .italic() :
                                       .headline)
                                .foregroundStyle(combineCosts() > listVM.cabalTotalPoints + listVM.cabalBonusPoints ?
                                                 Color.red :
                                                     .accentColor)
                            
                            Text("\(ritualVM.ritualCostPhase)")
                        }
                        
                        
                        //TOTAL COST TEXT
                        HStack {
                            Text("Total Ritual Cost: ")
                                .font(combineCosts() > listVM.cabalTotalPoints + listVM.cabalBonusPoints ?
                                     .headline
                                    .italic() :
                                        .headline
                                    )
                                .foregroundColor(
                                    combineCosts() > listVM.cabalTotalPoints + listVM.cabalBonusPoints ?
                                    Color.red :
                                        .accentColor
                                )
                                .bold()
                                .underline()
                                
                            Text("\(ritualVM.ritualCostTotal + ritualVM.ritualCostPhase)")
                        }
                        
//                        .padding(.vertical)

                        if (listVM.ahrimanAlive) {
                            ahrimanToggle()
                        }
                    }
                }
                
//              MARK: Actual List
                List {
                    ForEach(ritualVM.ritualClass, id: \.self.ritual.ritual)  { item in
                        ZStack {
                            RitualItemView(item: item)
                                .onTapGesture {
                                    ritualVM.toggle(item: item)
                                    if (item.doubleTap) { item.doubleTap = false }
                                }
                                .swipeActions {
                                    if (listVM.ahrimanAlive &&  !ritualVM.freebieTriggered) {
                                        Button("Ahriman") {
                                                ritualVM.toggleFreebie(item: item)
                                        }
                                        .tint(.screamerPink)
                                        
                                    }
                                    if (listVM.loreAlive) {
                                        Button("x2") {
                                            if (item.status == .off) {
                                                ritualVM.toggle(item: item)
                                            }
                                            ritualVM.doubleTapToggle(item: item)
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
