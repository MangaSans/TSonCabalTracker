//
//  ContentView.swift
//  TSonCabalTracker
//
//  Created by John Moyer on 2/24/23.
//

import SwiftUI
import CoreData

struct ListView: View {
    
//    let swipeToOpenSideMenu = UIGestureRecognizer(target: Self, action: <#T##Selector?#>)
    
    @EnvironmentObject var listVM: ListViewModel
    @EnvironmentObject var ritualVM: RitualListViewModel
    @State private var showingSideBar: Bool = false {
        willSet {
            if (!newValue) {
                listVM.getBonusPointsTotal()
            }
        }
    }
    
    @State private var boop = false
    
    func swipeButtons(item: UnitData) -> some View {
        HStack {
            Button(action: {listVM.deleteItem(item: item)}, label: {
                Image(systemName: "trash")
            })
            .tint(.pink)
            //There's gotta be a cleaner way to do this shit
            NavigationLink(destination: EditUnitView(
                itemToEdit: item,
                selectedUnit: listVM.getUnit(itemToEdit: item),
                tempEnhance: listVM.getEnhance(itemToEdit: item),
                nickname: listVM.getNickname(nick: item.nickname)),
                           label:{
                Image(systemName: "square.and.pencil")})
            .tint(.blue)
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    //MARK: Empty List Text
                    if(listVM.tsonsUnits.isEmpty) {
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
                    //MARK: Actual List
                    List {
                        ForEach(listVM.tsonsUnits) { item in
                            
                            Button {
                                listVM.updateItem(item: item)
                            } label: {
                                ListItemView(item: item)
                            }
                            .swipeActions {
                                swipeButtons(item: item)
                            }
                        }
                    }
                    .offset(x: showingSideBar ? 275 : 0)
                    .listStyle (
                        PlainListStyle()
                    )
                    
                    //MARK: Side Bar
                    if (showingSideBar) {
                        GeometryReader { geometry in
                            HStack {
                                SideMenuView()
                                    .offset(x: geometry.size.width / 100)
                                    .frame(width: 270)
                                Rectangle()
                                    .frame(width: geometry.size.width - 240)
//                                    .foregroundStyle(Color.white.opacity(0.1))
                                    .opacity(0.01)
                                    .onTapGesture {
                                        showingSideBar = false
                                    }
                                    .ignoresSafeArea()
                            }
                        }
                    }
                }
                

            if(!listVM.tsonsUnits.isEmpty) {
                    Text("Swipe Left to Edit/Delete a unit.")
                        .foregroundStyle(Color.gray)
                        .padding(.bottom)
                    }
        }
            
//            .navigationBarItems(
//                trailing: NavigationLink("Add a Unit", destination: AddItemView()))
            
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink("Add a Unit", destination: AddItemView())
            }
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    showingSideBar.toggle()
                }, label: {
                    ZStack {
                        Image(systemName: "line.3.horizontal")
                        if (listVM.cabalBonusPoints > 0) {
                            Circle()
                                .foregroundStyle(Color.red)
                                .position(x:+25)
                        }
                    }
                })
            }
        }
        .navigationTitle(
            listVM.cabalBonusPoints > 0 ?
            "Cabal Points: \(listVM.cabalTotalPoints) + \(listVM.cabalBonusPoints)"
            : "Cabal Points: \(listVM.cabalTotalPoints)"
        )
        .animation(.spring(), value: showingSideBar)
        .animation(.easeIn.delay(0.25), value: listVM.tsonsUnits)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ListView()
        }
        .environmentObject(ListViewModel())
        .environmentObject(RitualListViewModel())
    }
}

