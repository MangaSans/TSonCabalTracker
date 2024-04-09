//
//  RitualModel.swift
//  TSonCabalTracker
//
//  Created by John Moyer on 2/26/23.
//

import Foundation

//let decoder = JSONDecoder()

struct RitualList: Decodable {
    var rituals: [RitualModel]
}

//Bootleg ass way to get ids and a bool.
//struct Rituals: Decodable, Identifiable {
//    var ritual: String
//    var cost: Int
//    var description: String
//    var id: String
//    var isSelected: Bool
//    
//    init(ritual: String, cost: Int, description: String, id: String = UUID().uuidString, isSelected: Bool = false) {
//        self.ritual = ritual
//        self.cost = cost
//        self.description = description
//        self.id = id
//        self.isSelected = isSelected
//    }
//}

struct RitualModel: Decodable, Hashable {
    
//    let id: String
    let ritual: String
    let cost: Int
    let description: String
//    let isSelected: Bool
    
    init(ritualTitle: String, ritualCost: Int, ritualDesc: String) {
//        self.id = id
        self.ritual = ritualTitle
        self.cost = ritualCost
        self.description = ritualDesc
//        self.isSelected = false
    }
}

//func parseJSON() {
//    guard let path = Bundle.main.path(forResource: "data", ofType: "json")
//    else {
//        return
//    }
//
//    if let url = URL(filePath: path) {
//    }
//    do {
//        let jsonData = try Data(contentsOf: url)
//        let decoded: RitualModel = try! JSONDecoder().decode(RitualModel.self, from: jsonData)
//        print(decoded.description)
//        }
//        catch {
//            print("Error: \(error)")
//        }
//
//}

