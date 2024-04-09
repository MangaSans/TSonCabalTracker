//
//  ListViewModel.swift
//  TSonCabalTracker
//
//  Created by John Moyer on 2/24/23.
//

import Foundation
import CoreData

class ListViewModel: ObservableObject {
    
    @Published var tsonsUnits: [UnitData] = []
    @Published var cabalTotalPoints: Int = 0
    @Published var cabalBonusPoints: Int = 0
    @Published var helbruteActive = false
    @Published var helbruteBabble: Int = 0
    @Published var tzangorTrophy: Int = 0
    let container: NSPersistentContainer
    let dataFileName: String = "UnitData"
//    @Published var unitTypes: Unit
    
    init() {
        container = NSPersistentContainer(name: dataFileName)
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading Core Data. \(error)")
            } else {
                print("Core Data Loaded.")
            }
        }
        
        getItems()
    }
    
    func getItems() {

        let request = NSFetchRequest<UnitData>(entityName: dataFileName)
        
        do {
            try tsonsUnits = container.viewContext.fetch(request)
        } catch let error {
            print("Error loading data. \(error)")
        }
        
        getPointTotal()
    }
    
    func saveUnits() {
        do {
            try container.viewContext.save()
            getItems()
        } catch let error {
            print("Error saving data. \(error)")
        }
    }
    
    func getPointTotal() {
        cabalTotalPoints = 0
        for values in tsonsUnits {
            cabalTotalPoints += values.isAlive ? Int(values.pointValue) : 0
        }
        getBonusPointsTotal()
    }
        
    func updateItem(item: UnitData) {
//        if let index = tsonsUnits.firstIndex(where: {$0.id == item.id}) {
//            item.isAlive = item.isAlive ? false : true
        item.isAlive = !item.isAlive
//            getPointTotal()
            saveUnits()
//        }
    }
    
    func addItem(model: UnitEnum, nickname: String?) {
        var tempVal: Int
        var tempTitle: String
//        var newUnit: UnitData
        
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
        
//        newUnit = UnitModel(title: tempTitle, value: tempVal, nickname: nickname)
        let newUnit = UnitData(context: container.viewContext)
        newUnit.unitType = tempTitle
        newUnit.isAlive = true
        newUnit.nickname = nickname
        newUnit.pointValue = Int16(tempVal)
//        items.append(newUnit)
//        getPointTotal()
        saveUnits()
    }

//    func addItem(name: String, value: Int, nickname: String?) {
//        let newUnit = UnitModel(title: name, value: value, nickname: nickname)
//        items.append(newUnit)
//        getPointTotal()
//    }
    
    func deleteItem(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = tsonsUnits[index]
        container.viewContext.delete(entity)
        saveUnits()
    }
    
    func newGame() {
        for units in tsonsUnits {
            units.isAlive = true
        }
        resetBonusPoints()
        saveUnits()
    }
    
    func resetBonusPoints() {
        tzangorTrophy = 0; helbruteBabble = 0; cabalBonusPoints = 0
    }
    
    func getBonusPointsTotal() {
        cabalBonusPoints = 0
        cabalBonusPoints = tzangorTrophy + helbruteBabble
    }
    
    func clearArmy() {
        for units in tsonsUnits {
            container.viewContext.delete(units)
        }
        saveUnits()
    }
}
