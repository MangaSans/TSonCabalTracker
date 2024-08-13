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
    
    //Check if ritual can even be used outside shooting phase (current rules on the 10th ed data slate)
    //Takes ritual ID and spits out can be shown during this phase or not.
    func ritualPhaseChecker(ritualid: Int, currentPhase: Int) -> Bool {
        if (currentPhase != 2) {
            //Rituals 2, 4, and 5 can only be used during the shooting phase.
            switch ritualid {
            case 0: return true
            case 1: return false
            case 2: return true
            case 3: return false
            case 4: return false
            default: 
                print("Something messed up with the ritualPhaseChecker.")
                return false
            }
        } else {
            //Everything can be used in the shooting phase.
            return true
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
    
    func barColor() -> Color {
        switch ritualVM.phaseCounter {
        case 0: 
            return .brown
        case 1:
            return .screamerPink
        case 2: 
            return .purple
        case 3:
            return .blue
        case 4:
            return .darkerGrayer
        default:
            return .yellow
        }
    }
    
    func topBar() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0)
                .frame(maxHeight: 40)
                .padding(.horizontal)
                .foregroundColor(barColor())
                .animation(.easeOut, value: ritualVM.phaseCounter)
            
            HStack {
                    Text("\(phaseName(phaseNumber: ritualVM.phaseCounter)) Phase")
                        .font(.title3)
                        .italic()
                        .bold()
                        .foregroundStyle(Color.yellow)
                        .multilineTextAlignment(.trailing)
                        .padding()
                        .shadow(color: Color.black,radius: 5)
                
                
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
//                    if (!ritualVM.tutorialTextCleared) {
//                        HStack {
//                            Text("Swipe left on a ritual for Ahriman's/Lord of Forbidden Lore's Ability.")
//                                .multilineTextAlignment(.center)
//                                .font(.subheadline)
//                                .padding(.horizontal)
//                                .foregroundStyle(Color.white)
//                            Button(action: {
//                                ritualVM.tutorialTextCleared.toggle()
//                            }, label: {
//                                Image(systemName: "clear.fill")
//                                    .font(.title3)
//                                    .foregroundStyle(Color.red)
//                            })
//                            .padding()
//                        }
//                        .background(Color.gray)
//                        .cornerRadius(10.0)
//                        .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/, value: ritualVM.tutorialTextCleared)
//                    }
                    
                    ForEach(ritualVM.ritualClass, id: \.self.ritual.ritual)  { item in
                        ZStack {
                            if (ritualPhaseChecker(ritualid: item.identification, currentPhase: ritualVM.phaseCounter)) {
                                RitualItemView(item: item)
                                    .animation(.easeOut, value: item.status)
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
                            else {
                                RitualPlaceholderTab(item: item)
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
