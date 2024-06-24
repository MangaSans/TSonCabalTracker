//
//  SortModel.swift
//  TSonCabalTracker
//
//  Created by John Moyer on 5/26/24.
//

import Foundation

enum SortEnum: String, CaseIterable, Identifiable {
    var id: Self { self }
    
    case nickname = "Nickname"
    case pointValue = "Points Value"
    case unitName = "Unit Name"
}

