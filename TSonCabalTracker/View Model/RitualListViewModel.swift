//
//  RitualListViewModel.swift
//  TSonCabalTracker
//
//  Created by John Moyer on 3/1/23.
//

import Foundation

class RitualListViewModel: ObservableObject {
    
    @Published var rituals: [RitualModel] = []
    @Published var ritualCostTotal: Int = 0
    @Published var ritualCostPhase: Int = 0
    @Published var ritualClass: [RitualClass] = []
    @Published var freebieTriggered = false
    @Published var phaseCounter: Int = 0
    @Published var turnCounter: Int = 1
//    @Published var tutorialTextCleared: Bool = false
   
    init() {
        readFile()
    }
    

    func readFile() {
        //Can use a comma when using an if var with only one line of code being done if it works.
        if let url = Bundle.main.url(forResource: "RitualsTenth", withExtension: "json"),
            let data = try? Data(contentsOf: url) {
                let decoder = JSONDecoder()
            if let jsonData = try? decoder.decode(RitualList.self, from: data) {
                rituals = jsonData.rituals
                
//                Function for second array?
//                var tempRitual: RitualClass
                var temp = 0
                for i in rituals {
                    ritualClass.append(RitualClass(ritual: i, identification: temp))
                    print("\(ritualClass[temp].ritual.ritual)")
                    temp+=1
                }
                print("Ritual list loaded up.")
                
            }
            else {
                debugPrint("Error loading ritual list.")
            }
        }
    }
    
    func getTotalCost() {
        ritualCostPhase = 0
        for selected in ritualClass {
            if (selected.status == .freebie && selected.doubleTap){
                ritualCostPhase += selected.ritual.cost
            } else {
                ritualCostPhase += selected.status == .active ? (selected.doubleTap ? selected.ritual.cost * 2 : selected.ritual.cost) : 0
            }
        }
    }
    
    func newTurn() {
        ritualCostTotal = 0
        phaseCounter = 0
        turnCounter+=1
        for selected in ritualClass {
            selected.status = .off
            selected.doubleTap = false
        }
        getTotalCost()
    }
    
    func toggleFreebie(item: RitualClass) {
        for selected in ritualClass {
            if selected.status == .freebie {
                selected.status = .off
            }
        }
        item.status = .freebie
        freebieTriggered = true
        getTotalCost()
    }
    
    func toggle(item: RitualClass) {
        switch item.status {
        case .active:
            item.status = .off
        case .freebie:
            item.status = .off
            freebieTriggered = false
        case .off:
            item.status = .active
        }
        getTotalCost()
    }
    
    func newGame() {
        turnCounter = 1
        for item in ritualClass {
            item.status = .off
            item.doubleTap = false
        }
        freebieTriggered = false
        getTotalCost()
    }
    
    func doubleTapToggle(item: RitualClass) {
        for select in ritualClass {
            select.doubleTap = false
        }
        item.doubleTap.toggle()
        getTotalCost()
    }
    
    func nextPhase() {
        phaseCounter+=1
        if (phaseCounter == 5) {
            newTurn()
        } else {
            ritualCostTotal+=ritualCostPhase
            newPhase()
        }
    }
    
    func newPhase() {
        for item in ritualClass {
            item.status = .off
            item.doubleTap = false
        }
        getTotalCost()
    }
}

