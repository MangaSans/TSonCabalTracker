//
//  ContentView.swift
//  TSonCabalTracker
//
//  Created by John Moyer on 2/24/23.
//

import SwiftUI
import CoreData

struct ListView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    @EnvironmentObject var ritualListViewModel: RitualListViewModel
    @State private var showingSideBar: Bool = false {
        willSet {
            if (!newValue) {
                listViewModel.getBonusPointsTotal()
            }
        }
    }
    
    @State private var boop = false
    
    var body: some View {
        VStack {
            ZStack {
//                MARK: Empty List Text
                if(listViewModel.tsonsUnits.isEmpty) {
                    VStack {
                        Text("All is dust...")
                            .bold()
                            .italic()
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .foregroundStyle(Color.gray)
                            .offset(x: showingSideBar ? CGFloat(200) : 0)
                        Text("Add a unit up above.")
                            .foregroundStyle(Color.gray)
                            .offset(x: showingSideBar ? CGFloat(200) : 0)
                    }
                }
//                MARK: Actual List
                List {
                    ForEach(listViewModel.tsonsUnits) { item in
                        
                        Button {
                            listViewModel.updateItem(item: item)
                        } label: {
                            ListItemView(item: item)
                        }

                    }
                    .onDelete(perform: listViewModel.deleteItem)
                }
                .offset(x: showingSideBar ? 275 : 0)
                .listStyle (
                    PlainListStyle()
                )
                
//                MARK: Side Bar
                if (showingSideBar) {
                    GeometryReader { _ in
                        EmptyView()
                    }
                    .background(Color.gray.opacity(0.3))
                    .opacity(1.0)
                    .onTapGesture {
                        showingSideBar = false
                    }
                    
                    SideMenuView()
//                        .animation(.easeIn.delay(0.25), value: showingSideBar)
                }
                
            }
            .navigationTitle(
                listViewModel.cabalBonusPoints > 0 ?
                "Cabal Points: \(listViewModel.cabalTotalPoints) + \(listViewModel.cabalBonusPoints)"
                : "Cabal Points: \(listViewModel.cabalTotalPoints)"
            )
            .navigationBarItems(
                trailing: NavigationLink("Add a Unit", destination: AddItemView()))
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        showingSideBar.toggle()
                    }, label: {
                        Label("Toggle Sidebar", systemImage: "line.3.horizontal")
                    })
                }
            }

            if(!listViewModel.tsonsUnits.isEmpty) {
                Text("Swipe Left to Delete a unit.")
                    .foregroundStyle(Color.gray)
            }
        }
        .animation(.spring(), value: showingSideBar)
        .animation(.easeIn.delay(0.25), value: listViewModel.tsonsUnits)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListView()
        }
        .environmentObject(ListViewModel())
        .environmentObject(RitualListViewModel())
    }
}

