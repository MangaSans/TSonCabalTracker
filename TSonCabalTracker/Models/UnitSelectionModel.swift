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

enum UnitEnum: String, Identifiable, CaseIterable {
    case magnus = "Magnus the Red"
    case ahriman = "Ahriman"
    case exsorc = "Exhalted Sorcerer"
    case daemon = "Daemon Prince"
    case infernal = "Infernal Master"
    case sorc = "Sorcerer"
    case termsorc = "Sorcerer in Terminator Armor"
    case rubric = "Rubric Marine Squad"
    case scarab = "Scaran Occult Terminator Squad"
    case shaman = "Tzaangor Shaman"
    var id: Self { self }
}

enum EnhanceEnum:String, CaseIterable, Identifiable {
    case scrolls = "🧻 Athenaean Scrolls"
    case lore = "🧙‍♂️ Lord of Forbidden Lore"
    case none = "None"
    var id: Self { self }
}
