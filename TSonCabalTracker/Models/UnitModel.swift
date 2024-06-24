//
//  UnitModel.swift
//  TSonCabalTracker
//
//  Created by John Moyer on 2/24/23.
//

import Foundation

struct UnitModel: Identifiable, Codable, Hashable {
    let id: String
    let title: String
    let value: Int
    let isAlive: Bool
    let nickname: String?
    
    init(id: String = UUID().uuidString, title: String, value: Int, isAlive: Bool = true, nickname: String?) {
        self.id = id
        self.title = title
        self.value = value
        self.isAlive = isAlive
        self.nickname = nickname
    }
    
    func updateAlive() -> UnitModel {
        return UnitModel(id: id, title: title, value: value, isAlive: !isAlive, nickname: nickname)
    }
    
}

//Spell counter

//DON'T FORGET CULT SPELLS

//Magnus - 3 without being Warlord. All of them if he is.
//Ahriman - 3
//Daemon Prince - 2
