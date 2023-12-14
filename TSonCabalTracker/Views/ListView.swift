//
//  ContentView.swift
//  TSonCabalTracker
//
//  Created by John Moyer on 2/24/23.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    
    var body: some View {
        VStack {
            ZStack {
                List {
                    ForEach(listViewModel.items) { item in
                        ListItemView(item: item)
                            .onTapGesture {
                                listViewModel.updateItem(item: item)
                            }
                    }
                    .onDelete(perform: listViewModel.deleteItem)
                }
                .listStyle (
                    PlainListStyle()
                )
            }
            .navigationTitle("Cabal Points: \(listViewModel.cabalTotalPoints)")
            .navigationBarItems(
                leading: NavigationLink("Cabalistic Rituals", destination: RitualListView()),
                trailing: NavigationLink("Add a Unit", destination: AddItemView()))
            Text("Swipe Left to Delete a unit.")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListView()
        }
        .environmentObject(ListViewModel())
    }
}
