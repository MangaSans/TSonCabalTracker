//
//  ListViewModel.swift
//  TSonCabalTracker
//
//  Created by John Moyer on 2/24/23.
//

import Foundation

class ListViewModel: ObservableObject {
    
    @Published var items: [UnitModel] = [] {
        didSet {
            saveItems()
        }
    }
    @Published var cabalTotalPoints: Int = 0
//    @Published var unitTypes: Unit
    let itemsKey: String = "items_list"
    
    init() {
        getItems()
        getPointTotal()
    }
    
    func getItems() {
//        let newItems = [
//            UnitModel(title: "Magnus the Red", value: 4, nickname: nil),
//            UnitModel(title: "Ahriman", value: 3, nickname: nil),
//            UnitModel(title: "Exhalted Sorcerer", value: 3, nickname: "Tiny Tim")
//        ]
//        items.append(contentsOf: newItems)
        
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([UnitModel].self, from: data)
        else {
            return
        }
        self.items = savedItems
        getPointTotal()
    }
    
    func getPointTotal() {
        cabalTotalPoints = 0
        for values in items {
            cabalTotalPoints += values.isAlive ? values.value : 0
        }
    }
    
    func updateItem(item: UnitModel) {
        if let index = items.firstIndex(where: {$0.id == item.id}) {
            items[index] = item.updateAlive()
            getPointTotal()
        }
    }
    
    func addItem(model: UnitEnum, nickname: String?) {
        var tempVal: Int
        var tempTitle: String
        var newUnit: UnitModel
        
        //MARK: Model Cabal Points Values
        switch model {
            case .magnus:
            tempTitle = "Magnus the Red"
            tempVal = 4
                
            case .ahriman:
            tempTitle = "Ahriman"
            tempVal = 3

            case .exsorc:
            tempTitle = "Exhalted Sorcerer"
            tempVal = 3

            case .daemon:
            tempTitle = "Daemon Prince"
            tempVal = 3

            case .infernal:
            tempTitle = "Infernal Master"
            tempVal = 2

            case .sorc:
            tempTitle = "Sorcerer"
            tempVal = 2

            case .termsorc:
            tempTitle = "Sorcerer in Terminator Armor"
            tempVal = 2

            case .rubric:
            tempTitle = "Rubric Marine Squad"
            tempVal = 1

            case .scarab:
            tempTitle = "Scarab Occult Terminator Squad"
            tempVal = 1

            case .shaman:
            tempTitle = "Tzaangor Shaman"
            tempVal = 1
        }
        
        newUnit = UnitModel(title: tempTitle, value: tempVal, nickname: nickname)
        items.append(newUnit)
        getPointTotal()
    }

//    func addItem(name: String, value: Int, nickname: String?) {
//        let newUnit = UnitModel(title: name, value: value, nickname: nickname)
//        items.append(newUnit)
//        getPointTotal()
//    }
    
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
        getPointTotal()
    }
    
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
}
