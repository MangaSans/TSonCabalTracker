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
    @State var nickname: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Pick a Model:")
                    .underline()
                Picker("Which Unit?", selection: $selectedUnit, content: {
                    ForEach(UnitEnum.allCases) { item in
                        Text("\(item.rawValue)")
                    }
                })
                    
                Divider()
                
                Text("Extra Info:")
                    .underline()
                    .padding()
//                Form {
                    HStack{
                        Text("Nickname:")
                        TextField("Optional", text: $nickname)
                    }
                    
//                    Text ("Spells Placeholder 🧙‍♂️")
//                    Text ("Spells Placeholder 🧙‍♂️")
//                    Text ("Spells Placeholder 🧙‍♂️")
//                }
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
        Spacer()
    }
    
    func saveButtonPressed() {
        if nickname.emptySpace {
            listViewModel.addItem(model: selectedUnit, nickname: nil)
        }
        else {
            listViewModel.addItem(model: selectedUnit, nickname: nickname)
        }
        
        presentationMode.wrappedValue.dismiss()
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
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
