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
    @Published var helbruteBabble: Int = 0 {
        didSet {
            getBonusPointsTotal()
        }
    }
    @Published var tzangorTrophy: Int = 0 {
        didSet {
            getBonusPointsTotal()
        }
    }
    
    //Bools for checking living stuff
    @Published var ahrimanAlive = false
    @Published var loreAlive = false
    
    //Variables for sorting
    var sortAscending = false {
        didSet {
            getItems()
        }
    }
    var sortingBy: SortEnum = .pointValue {
        didSet {
            getItems()
        }
    }
    
    let container: NSPersistentContainer
    let dataFileName: String = "UnitData"
    
    
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
        let pointSort = NSSortDescriptor(key: getSortName(), ascending: sortAscending)
        request.sortDescriptors = [pointSort]
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
        var foundAhriman = false
        var foundLore = false
        for values in tsonsUnits {
            
            if values.loreHolder {
                foundLore = true
                if values.isAlive { loreAlive = true }
                else { loreAlive = false }
            }
            
            if values.unitType! == "Ahriman" {
                foundAhriman = true
                if values.isAlive { ahrimanAlive = true }
                else { ahrimanAlive = false }
            }
            
            cabalTotalPoints += values.isAlive ? (values.scrollHolder ? Int(values.pointValue) + 1 : Int(values.pointValue)) : 0
        }
        print("Ahriman is \(ahrimanAlive) and the Lore Lord is \(loreAlive).")
        getBonusPointsTotal()
        
        if !foundLore { loreAlive = false }
        if !foundAhriman { ahrimanAlive = false }
    }
        
    func updateItem(item: UnitData) {
        item.isAlive = !item.isAlive
            saveUnits()
    }
    
    func addItem(model: UnitEnum, nickname: String?, enhanced: EnhanceEnum, edit: Bool = false, unitToEdit: UnitData? = nil) {
        
        var tempVal: Int
        var tempTitle: String
        var tempLore, tempScroll: Bool
        
        //MARK: Model Cabal Points Values
        switch model {
            case .magnus:
            tempTitle = UnitTypeString().magnus
            tempVal = 4
                
            case .ahriman:
            tempTitle = UnitTypeString().ahriman
            tempVal = 3

            case .exsorc:
            tempTitle = UnitTypeString().exhalted
            tempVal = 2

            case .daemon:
            tempTitle = UnitTypeString().prince
            tempVal = 2

            case .infernal:
            tempTitle = UnitTypeString().infernal
            tempVal = 2

            case .sorc:
            tempTitle = UnitTypeString().sorcerer
            tempVal = 1

            case .termsorc:
            tempTitle = UnitTypeString().termSorc
            tempVal = 2

            case .rubric:
            tempTitle = UnitTypeString().rubric
            tempVal = 1

            case .scarab:
            tempTitle = UnitTypeString().scarab
            tempVal = 1

            case .shaman:
            tempTitle = UnitTypeString().shaman
            tempVal = 1
        }
        
        switch enhanced {
        case .lore:
            checkLore()
            tempLore = true; tempScroll = false
        case .scrolls:
            checkScrolls()
            tempLore = false; tempScroll = true
        case .none:
            tempLore = false; tempScroll = false
        }
        if (!edit) {
            let newUnit = UnitData(context: container.viewContext)

            newUnit.unitType = tempTitle
            newUnit.isAlive = true
            newUnit.nickname = nickname
            newUnit.pointValue = Int16(tempVal)
            newUnit.loreHolder = tempLore
            newUnit.scrollHolder = tempScroll
        } else {
            unitToEdit?.unitType = tempTitle
            unitToEdit?.pointValue = Int16(tempVal)
            unitToEdit?.nickname = nickname
            unitToEdit?.loreHolder = tempLore
            unitToEdit?.scrollHolder = tempScroll
        }
        
        //Probably to do with get/save order, but need to do initial get to have the list reorganize itself after an add/edit
        getItems()
        saveUnits()
    }
    
    func deleteItem(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = tsonsUnits[index]
        container.viewContext.delete(entity)
        saveUnits()
    }
    
    func deleteItem(item: UnitData){
        container.viewContext.delete(item)
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
    
    func checkScrolls() {
        for unit in tsonsUnits {
            if unit.scrollHolder { unit.scrollHolder = false }
        }
    }
    
    func checkLore() {
        for unit in tsonsUnits {
            if unit.loreHolder { unit.loreHolder = false }
        }
    }
    
    
    func getUnit(itemToEdit: UnitData) -> UnitEnum {
        switch itemToEdit.unitType {
        case UnitTypeString().magnus:
            return .magnus
        case UnitTypeString().ahriman:
            return .ahriman
        case UnitTypeString().exhalted:
            return .exsorc
        case UnitTypeString().infernal:
            return .infernal
        case UnitTypeString().prince:
            return .daemon
        case UnitTypeString().rubric:
            return .rubric
        case UnitTypeString().scarab:
            return .scarab
        case UnitTypeString().shaman:
            return .shaman
        case UnitTypeString().sorcerer:
            return .sorc
        case UnitTypeString().termSorc:
            return .termsorc
        default:
            return .rubric
        }
    }
    
    func getEnhance(itemToEdit: UnitData) -> EnhanceEnum {
        if itemToEdit.scrollHolder { return .scrolls }
        else if itemToEdit.loreHolder { return .lore }
        else { return .none }
    }
    
    func getNickname(nick: String?) -> String{
        if nick == nil {
            return ""
        } else {
            return (nick)!
        }
    }
    
    func getSortName() -> String {
        switch sortingBy {
        case .nickname:
            return "nickname"
        case .pointValue:
            return "pointValue"
        case .unitName:
            return "unitType"
        }
    }
}
