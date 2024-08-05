//
//  ContentView.swift
//  TSonCabalTracker
//
//  Created by John Moyer on 2/24/23.
//

import SwiftUI
import CoreData

struct ListView: View {
    
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
    
    //Pop up timer to auto close
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    //Moving swipe buttons to a func for ease on the compiler.
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
                                if (!showingSideBar) {
                                    swipeButtons(item: item)
                                }
                                
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
                                    .opacity(0.01)
                                    .onTapGesture {
                                        showingSideBar = false
                                    }
//                                    .ignoresSafeArea()
                            }
                        }
                    }
                    
                    if listVM.duplicateAlert {
                        ZStack{
                            DuplicatePopupView()
                                .onReceive(timer, perform: { _ in
                                    listVM.duplicateAlert = false
                                })
                            Button(action: {
                                listVM.duplicateAlert = false
                            }, label: {
                                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                    .ignoresSafeArea()
                                    .foregroundStyle(Color.clear.opacity(0.0))
                                    
                            })
                        }
                    }
                }
                
            //Prompt to tell people to swipe on units.
            if(!listVM.tsonsUnits.isEmpty) {
                    Text("Swipe Left to Edit/Delete a unit.")
                        .foregroundStyle(Color.gray)
                        .padding(.bottom)
                    }
            }
        }
        //Swipe gestures for opening/closing side bar. NEED TO FIND A DIFFERENT METHOD
//        .gesture(DragGesture(minimumDistance: 10, coordinateSpace: .local).onEnded({ value in
//            if (value.translation.width > 0 && !showingSideBar) {
//                showingSideBar.toggle()
//            }
//            if (value.translation.width < 0 && showingSideBar) {
//                showingSideBar.toggle()
//            }
//        }))
        
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

