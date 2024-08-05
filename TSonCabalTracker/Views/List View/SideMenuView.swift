//
//  SideMenuView.swift
//  TSonCabalTracker
//
//  Created by John Moyer on 3/6/24.
//

import SwiftUI

struct SideMenuView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    @EnvironmentObject var ritualVM: RitualListViewModel
    @State private var isShowingConfirm = false
    var isAscending = false
    
    let menuWidth: CGFloat = 270
    let babbleRange = 0 ... 20
    let trophyRange = 0 ... 20
    
    var body: some View {
        
        VStack  {
            Spacer()
            List {
                Section (header:Text("Unit abilities")){
                    HStack {
                        Stepper(value: $listViewModel.helbruteBabble, in: babbleRange) {
                            HStack{
                                Text("Helbrute Babblin'")
                                Text("\(listViewModel.helbruteBabble)")
                                    .foregroundStyle(Color.blue)
                                    .bold()
                            }
                        }
                    }
                    
                    HStack {
                        Stepper(value: $listViewModel.tzangorTrophy, in: trophyRange) {
                            HStack {
                                Text("Tzaangor Trophies")
                                Text("\(listViewModel.tzangorTrophy)")
                                    .foregroundStyle(Color.blue)
                                    .bold()
                            }
                        }
                        
                    }
                    Button(action: {
                        listViewModel.resetBonusPoints()
                    }, label: {
                        Text("Reset Ability Counter")
                    })
                }
                Section (header: Text("Sorting")) {
                    Picker("Sort By:", selection: $listViewModel.sortingBy) {
                        ForEach (SortEnum.allCases) {caseName in
                            Text("\(caseName.rawValue)")
                        }
                    }
                    Toggle(isOn: $listViewModel.sortAscending, label: {
                        Text("Ascending?")
                    })
                }
                Section (header:Text("Reset buttons")){
                    Button(action: {
                        listViewModel.newGame()
                    }, label: {
                        Text("Reset Army Status")
                    })
                    Button(action: {
                        isShowingConfirm = true
                    }, label: {
                        Text("New Game Start")
                    })
                        .foregroundStyle(Color.red)
                        .confirmationDialog("Reset army status and active rituals?", isPresented: $isShowingConfirm, titleVisibility: .visible) {
                            Button("Confirm", role: .destructive) {
                                listViewModel.newGame()
                                ritualVM.newGame()
                            }
                        }
                    
                }
                //Tap off view to close menu
            }
            .listStyle(.sidebar)
        }
        .frame(maxWidth: self.menuWidth)
        .animation(.default, value: menuWidth)
    }
}

#Preview {
    SideMenuView()
        .environmentObject(ListViewModel())
        .environmentObject(RitualListViewModel())
}
