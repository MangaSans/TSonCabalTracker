//
//  SideMenuView.swift
//  TSonCabalTracker
//
//  Created by John Moyer on 3/6/24.
//

import SwiftUI

struct SideMenuView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    @EnvironmentObject var ritualViewModel: RitualListViewModel
    
    let menuWidth: CGFloat = 270
    let unitRange = 0 ... 3
//    let menuOpen: Bool
//    let menuClose: () -> Void
    
    var body: some View {
        
        ZStack {
            List {
                Section (header:Text("Unit abilities")){
                    HStack {
//                        Text("HELBRUTE BABBLIN")

                        Stepper(value: $listViewModel.helbruteBabble, in: unitRange) {
                            HStack{
                                Text("Helbrute Babblin'")
                                Text("\(listViewModel.helbruteBabble)")
                                    .foregroundStyle(Color.blue)
                                    .bold()
                            }
                        }
                    }
                    HStack {

                        Stepper(value: $listViewModel.tzangorTrophy, in: unitRange) {
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
                Section (header:Text("Reset buttons")){
                    Button(action: {
                        listViewModel.newGame()
//                        ritualViewModel.newTurn()
                    }, label: {
                        Text("New Game Start")
                    })
                        .foregroundStyle(Color.red)
                    
                }
                
            }
            .listStyle(.plain)
            .background(Color.white.opacity(0.5))
            .frame(width: self.menuWidth)
            .animation(.default, value: menuWidth)
            .offset(x: -(menuWidth/5))
        }
        
    }
}

#Preview {
    SideMenuView()
        .environmentObject(ListViewModel())
}
