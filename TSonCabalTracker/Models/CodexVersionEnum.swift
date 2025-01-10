//
//  CodexVersionEnum.swift
//  TSonCabalTracker
//
//  Created by John Moyer on 10/15/24.
//

import Foundation

    enum CodexVersionEnum: String, CaseIterable, Identifiable {
        var id: Self { self }
        
        case tenth = "10th Edition Vanilla"
        case data0624 = "Dataslate June/2024"
    }
