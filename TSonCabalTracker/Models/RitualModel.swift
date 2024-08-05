//
//  RitualModel.swift
//  TSonCabalTracker
//
//  Created by John Moyer on 2/26/23.
//

import Foundation

struct RitualList: Decodable {
    var rituals: [RitualModel]
}

enum phases {
    case command 
    case movement
    case shooting
    case charge
    case combat
}

class RitualClass {
    var ritual: RitualModel
    var status: activity = activity.off
    var identification: Int
    var doubleTap = false
    
    init(ritual: RitualModel, identification: Int) {
        self.ritual = ritual
        self.identification = identification
    }
}

struct RitualModel: Decodable, Hashable {
    let ritual: String
    let cost: Int
    let description: String
}

enum activity {
    case off
    case active
    case freebie
}

//Didn't need it, holding it for ref later.
//extension Bundle {
//    func decode<T: Decodable>(file:String) -> T {
//        guard let url = self.url(forResource: file, withExtension: nil) else {
//            fatalError("Could not find \(file) in the project.")
//        }
//        guard let data = try? Data(contentsOf: url) else {
//            fatalError("Could not load \(file) in the project.")
//        }
//        
//        let decoder = JSONDecoder()
//        
//        guard let loadedData = try? decoder.decode(T.self, from: data) else {
//            fatalError("Could not decode \(file) in the project.")
//        }
//        
//        return loadedData
//    }
//}
