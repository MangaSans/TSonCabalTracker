//
//  UnitSelectionModel.swift
//  TSonCabalTracker
//
//  Created by John Moyer on 2/24/23.
//

import Foundation

struct Model: Hashable, Identifiable {
    var name: String
    var points: Int
    var id: String
}

enum Unit: String, Identifiable, CaseIterable {
    case magnus = "Magnus the Red"
    case ahriman = "Ahriman"
    case exsorc = "Exhalted Sorcerer"
    case daemon = "Daemon Prince"
    case infernal = "Infernal Master"
    case sorc = "Sorcerer"
    case termsorc = "Sorcerer in Terminator Armor"
    case rubric = "Rubric Marine Squad"
    case scarab = "Scaran Occult Terminators"
    case shaman = "Tzaangor Shaman"
    var id: Self { self }
}

//struct UnitSelections {
//    let model: Model
//    
//    let unitOptions: [Model] = [
//        Model(name: "Magnus the Red", points: 4),
//        Model(name: "Ahriman", points: 3),
//        Model(name: "Exhalted Sorcerer", points: 3),
//        Model(name: "Daemon Prince", points: 3),
//        Model(name: "Infernal Master", points: 2),
//        Model(name: "Sorcerer", points: 2),
//        Model(name: "Sorcerer in Terminator Armor", points: 2),
//        Model(name: "Rubric Marine Squad", points: 1),
//        Model(name: "Scarab Occult Terminator Squad", points: 1),
//        Model(name: "Tzaangor Shaman", points: 1)
//    ]
//}
