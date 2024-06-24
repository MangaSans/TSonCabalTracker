//
//  AddView.swift
//  TSonCabalTracker
//
//  Created by John Moyer on 2/24/23.
//

import SwiftUI

struct AddItemView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    @State var selectedUnit: UnitEnum = UnitEnum.rubric
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var tempEnhance: EnhanceEnum = .none
    
    @State var tempLore: Bool = false
    @State var tempScroll: Bool = false
    
    @State var itemToEdit: UnitData? 
    
    private var validUnit: Bool {
        //There's gotta be a cleaner way to do this.
        if selectedUnit == .daemon ||
            selectedUnit == .exsorc ||
            selectedUnit == .infernal ||
            selectedUnit == .shaman ||
            selectedUnit == .sorc ||
            selectedUnit == .termsorc {
            return true
        } else {
            return false
        }
    }
    
    @State var nickname: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Pick a Model:")
                    .underline()
                Picker("Which Unit?", selection: $selectedUnit, content: {
                    ForEach(UnitEnum.allCases) { item in
                        Text("\(item.rawValue)")
                    }
                })
                
                Divider()
                
                    VStack {
                        Text("Enhancements:")
                            .underline()
                            .padding()
                        if (validUnit) {
                            
                            Picker("Enhancements?", selection: $tempEnhance) {
                                ForEach(EnhanceEnum.allCases) { item in
                                    Text("\(item.rawValue)")
                                }
                            }
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
                            Text("Nickname: ")
                            TextField("Optional", text: $nickname)
                            .textFieldStyle(.roundedBorder)
                            .background(Color.blue)
                        }
                }

                Spacer()
                
                Divider()
                
                Button(action: saveButtonPressed, label: {
                Text("Save")
                        .foregroundColor(Color.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                })
            }
        }
        .navigationTitle("Add a Unit")
        .padding(16)
    }
    
    func saveButtonPressed() {
        if nickname.emptySpace {
            listViewModel.addItem(model: selectedUnit, nickname: nil, enhanced: tempEnhance)
        }
        else {
            listViewModel.addItem(model: selectedUnit, nickname: nickname, enhanced: tempEnhance)
        }
        
        presentationMode.wrappedValue.dismiss()
    }
    
    func selectedUnitPicker(picked: String) -> UnitEnum {
        switch picked {
        case UnitTypeString().magnus:
            return .magnus
                
        case UnitTypeString().ahriman:
            return .ahriman

        case UnitTypeString().exhalted:
            return .exsorc

        case UnitTypeString().prince:
            return .daemon

        case UnitTypeString().infernal:
            return .infernal

        case UnitTypeString().sorcerer:
            return .sorc

        case UnitTypeString().termSorc:
            return .termsorc

        case UnitTypeString().rubric:
            return .rubric

        case UnitTypeString().scarab:
            return .scarab

        case UnitTypeString().shaman:
            return .shaman
            
        default:
            return .rubric
        }
    }
    
    func editMode() {
        nickname = (itemToEdit?.nickname)!
        selectedUnit = selectedUnitPicker(picked: (itemToEdit?.unitType)!)
        if (itemToEdit?.scrollHolder)! { tempEnhance = .scrolls }
        else if (itemToEdit?.loreHolder)! { tempEnhance = .lore }
        else { tempEnhance = .none }
    }
}


struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddItemView()
        }
        .environmentObject(ListViewModel())
    }
}

extension String {
    var emptySpace: Bool {
        return self.trimmingCharacters(in: .whitespaces).isEmpty
    }
}
