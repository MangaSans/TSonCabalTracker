//
//  EditUnitView.swift
//  TSonCabalTracker
//
//  Created by John Moyer on 5/5/24.
//

import SwiftUI

struct EditUnitView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var itemToEdit: UnitData?
    
    @State var selectedUnit: UnitEnum
    @State var tempEnhance: EnhanceEnum
    
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
    @State var nickname: String
    
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
            }
            
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
                        Text("Nickname:")
                        TextField("Optional", text: $nickname)
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
        .navigationTitle("Edit this Unit")
        .padding(16)
    }
    
    func saveButtonPressed() {
        if nickname.emptySpace {
            listViewModel.addItem(model: selectedUnit, nickname: nil, enhanced: tempEnhance, edit: true, unitToEdit: itemToEdit)
        }
        else {
            listViewModel.addItem(model: selectedUnit, nickname: nickname, enhanced: tempEnhance, edit: true, unitToEdit: itemToEdit)
        }
        
        presentationMode.wrappedValue.dismiss()
    }
    
    func getNickname() -> String {
        if itemToEdit?.nickname == nil {
            return ""
        } else {
            return (itemToEdit?.nickname)!
        }
    }
}

//#Preview {
//    EditUnitView()
//        .environmentObject(ListViewModel())
//}
