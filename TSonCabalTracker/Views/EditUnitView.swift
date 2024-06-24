//
//  EditUnitView.swift
//  TSonCabalTracker
//
//  Created by John Moyer on 4/21/24.
//

import SwiftUI

struct EditUnitView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    
    var unitToEdit: UnitData
    
    var toEnum: UnitEnum {
        getEnumFromData(data: unitToEdit)
    }
    
    var tempNickname: String? {
        return unitToEdit.nickname ?? ""
    }
    
    var tempEnhance: EnhanceEnum {
        if unitToEdit.scrollHolder {
            return .scrolls
        } else if unitToEdit.loreHolder {
            return .lore
        } else {
            return .none
        }
    }
    
    private var validUnit: Bool {
        //There's gotta be a cleaner way to do this.
        if unitToEdit.unitType! == UnitTypeString().prince ||
            unitToEdit.unitType! == UnitTypeString().exhalted ||
            unitToEdit.unitType! == UnitTypeString().infernal ||
            unitToEdit.unitType! == UnitTypeString().shaman ||
            unitToEdit.unitType! == UnitTypeString().sorcerer ||
            unitToEdit.unitType! == UnitTypeString().termSorc {
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Pick a Model:")
                    .underline()
                //                Picker("Which Unit?", selection: $toEnum, content: {
                //                    ForEach(UnitEnum.allCases) { item in
                //                        Text("\(item.rawValue)")
                //                    }
                //                })
                
                Divider()
                
                VStack {
                    Text("Enhancements:")
                        .underline()
                        .padding()
                    if (validUnit) {
                        
                        //                            Picker("Enhancements?", selection: tempEnhance) {
                        //                                ForEach(EnhanceEnum.allCases) { item in
                        //                                    Text("\(item.rawValue)")
                        //                                }
                        //                            }
                    } else {
                        Text("Only Non-Named Characters can recieve enhancements.")
                    }
                }
                .padding()
                
                Divider()
                
                VStack{
                    Text("Extra Info:")
                        .underline()
                        .padding()
                    
                    HStack{
                        Text("Nickname:")
                        //                            TextField("Optional", text: tempNickname)
                    }
                }
                
                Spacer()
                
                Divider()
                
//                Button(action: print("Hi"), label: {
//                    Text("Save")
//                        .foregroundColor(Color.white)
//                        .frame(height: 55)
//                        .frame(maxWidth: .infinity)
//                        .background(Color.accentColor)
//                        .cornerRadius(10)
//                })
            }
        }
        .navigationTitle("Add a Unit")
        .padding(16)
    }
    
    //    func saveButtonPressed() {
    //        if nickname.emptySpace {
    //            listViewModel.addItem(model: selectedUnit, nickname: nil, enhanced: tempEnhance)
    //        }
    //        else {
    //            listViewModel.addItem(model: selectedUnit, nickname: nickname, enhanced: tempEnhance)
    //        }
    //
    //        presentationMode.wrappedValue.dismiss()
    //    }
    
    func getEnumFromData(data: UnitData) -> UnitEnum {
        switch data.unitType {
        case UnitTypeString().ahriman:
            return .ahriman
        case UnitTypeString().exhalted:
            return .exsorc
        case UnitTypeString().infernal:
            return .infernal
        case UnitTypeString().magnus:
            return .magnus
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
}
    
    
//    #Preview {
//        EditUnitView(unitToEdit: ListViewModel().tsonsUnits[0])
//            .environmentObject(ListViewModel())
//    }

