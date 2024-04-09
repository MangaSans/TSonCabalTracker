//
//  RitualListViewModel.swift
//  TSonCabalTracker
//
//  Created by John Moyer on 3/1/23.
//

import Foundation


class RitualListViewModel: ObservableObject {
    
    @Published var rituals: [RitualModel] = []
    @Published var isSelected: [Bool] = []
    @Published var ritualCostTotal: Int = 0
    @Published var resetCalled = false
//    @Published var ritualCostArray: [Int]
//    @Published var trueRituals: [Rituals] = []
   
    init() {
        readFile()
        ritualCostTotal = 0
    }
    

    func readFile() {
        //Can use a comma when using an if var with only one line of code being done if it works.
        if let url = Bundle.main.url(forResource: "RitualsTenth", withExtension: "json"),
            let data = try? Data(contentsOf: url) {
                let decoder = JSONDecoder()
            if let jsonData = try? decoder.decode(RitualList.self, from: data) {
                rituals = jsonData.rituals
                
                
//                var i = 0
//                for data in rituals {
//                    rituals[i].cost = data.cost
//                    i+=1
//                }
            }
            else {
                debugPrint("Uh oh")
            }
//            for spell in rituals {
//                let isSelected = false
//            }
        }
    }
    
    func activatedRitual(item: RitualModel) {
        ritualCostTotal += item.cost
    }
    
    func deactivatedRitual(item: RitualModel) {
        ritualCostTotal -= item.cost
    }
    
    func newTurn() {
//        ritualCostTotal = 0
        resetCalled = true
    }
//    func getTotalCost() {
//        ritualCostTotal = 0
//        for selected in rituals {
//            ritualCostTotal += selected.isSelected ? selected.cost : 0
//        }
//    }
//
//    func tapped(selected: RitualModel) {
//        selected.isSelected
//    }
}

