//
//  RitualListView.swift
//  TSonCabalTracker
//
//  Created by John Moyer on 2/26/23.
//

import SwiftUI

struct RitualListView: View {
    
    @EnvironmentObject var ritualListViewModel: RitualListViewModel
    @EnvironmentObject var listViewModel: ListViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Cabal Points: ")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                    Text("\(listViewModel.cabalTotalPoints)")
                        .font(.headline)
                }
                .padding()
                
                List {
                    ForEach(ritualListViewModel.rituals, id: \.self) { item in
                        RitualItemView(item: item)
                    }
                }
            }
        }
        .navigationTitle("Cabalistic Rituals")
        .padding(16)
        Spacer()
    }
}

struct CabalListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            RitualListView()
        }
        .environmentObject(RitualListViewModel())
        .environmentObject(ListViewModel())
    }
}
