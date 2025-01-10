//
//  RitualUnitStatusBar.swift
//  TSonCabalTracker
//
//  Created by John Moyer on 11/2/24.
//

import SwiftUI

struct RitualUnitStatusBar: View {
    @EnvironmentObject var listVM: ListViewModel
    @EnvironmentObject var ritualVM: RitualListViewModel
    
    @State var expandedView: Bool = false
    
    func ahrimanToggle() -> some View {
        Toggle(isOn: $ritualVM.freebieTriggered) {
            Text("Free Cast Used? (Once per game)")
                .foregroundStyle(Color.yellow)
                .font(.footnote)
                .multilineTextAlignment(.center)
                .shadow(color: Color.gray, radius: 15, y: 5)
        }
        .toggleStyle(CheckToggleStyle())
    }
    
    func ahrimanStatusString() -> String {
        if listVM.ahrimanListed {
            if listVM.ahrimanAlive {
                if ritualVM.freebieTriggered {
                    return "Ahriman's ability was used this game."
                } else {
                    return "Ahriman can cast for free."
                }
            } else {
                return "Ahriman is slain."
            }
        }
        else {
           return "Ahriman is not in your list."
        }
    }
    
    func ahrimanCanFreebie() -> Bool {
        if listVM.ahrimanAlive && !ritualVM.freebieTriggered {
            return true
        } else { return false }
    }
    
    func loreStatus() -> String {
        if listVM.loreListed {
            if listVM.loreAlive {
                return "Lord of Forbidden Lore can cast again."
            } else {
                return "The Lord of Forbidden Lore is slain."
            }
        } else {
            return "There is no Lord of Forbidden Lore in your army."
        }
    }
    
    var body: some View {
        ZStack {
        HStack {
            
                VStack {
                    HStack {
                        Image(systemName: ahrimanCanFreebie() ? "person.fill.checkmark" : "person.fill.xmark")
                            .foregroundStyle(ahrimanCanFreebie() ? Color.green : Color.red)
                        Text("Ahriman")
                            .font( expandedView ? .callout : .footnote)
                            .bold(expandedView)
                            .padding(.trailing)
                    }
                    
                    if expandedView {
                        Text ( ahrimanStatusString() )
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                        
                        if listVM.ahrimanListed { ahrimanToggle() }
                    }
                }
                .padding(.horizontal)
                VStack {
                    HStack {
                        Image(systemName: listVM.loreAlive ? "person.fill.checkmark" : "person.fill.xmark")
                            .padding(.leading)
                            .foregroundStyle(listVM.loreAlive ? Color.green : Color.red)
                        Text("Lord of Forbidden Lore")
                            .font( expandedView ? .callout : .footnote)
                            .bold(expandedView)
                    }
                    
                    if expandedView {
                        Text( loreStatus())
                            .font(.footnote)
                            .padding(.leading)
                            .multilineTextAlignment(.center)
                    }
                }
                .padding(.horizontal)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            expandedView.toggle()
            print("Tapped bar.")
        }
        .animation(.easeOut(duration: 0.2), value: expandedView)
        
//        VStack {
//            HStack {
//                Image(systemName: ahrimanCanFreebie() ? "person.fill.checkmark" : "person.fill.xmark")
//                    .foregroundStyle(ahrimanCanFreebie() ? Color.green : Color.red)
//                Text("Ahriman")
//                    .font( expandedView ? .callout : .footnote)
//                    .bold(expandedView)
//                    .padding(.trailing)
//                
//                
//                Image(systemName: listVM.loreAlive ? "person.fill.checkmark" : "person.fill.xmark")
//                    .padding(.leading)
//                    .foregroundStyle(listVM.loreAlive ? Color.green : Color.red)
//                Text("Lord of Forbidden Lore")
//                    .font( expandedView ? .callout : .footnote)
//                    .bold(expandedView)
//            }
//            .onTapGesture {
//                expandedView.toggle()
//            }
//            .animation(.easeOut(duration: 0.2), value: expandedView)
//            
//            if (expandedView) {
//                HStack {
//                    VStack{
//                        Text ( ahrimanCanFreebie() ? "Ariman can cast one free spell." : "Ahriman is dead or cannot cast a free spell.")
//                            .font(.footnote)
//                            .multilineTextAlignment(.center)
//                        
//                        ahrimanToggle()
//                    }
//                    .padding(.trailing)
//                    
//                    Text( listVM.loreAlive ? "The holder of Forbidden Lore is alive." : "There is no living holder of Forbidden Lore.")
//                        .font(.footnote)
//                        .padding(.leading)
//                        .multilineTextAlignment(.center)
//                }
//            }
//        }
        .onTapBackground(enabled: expandedView) {
            expandedView = false
        }
    }
}

//#Preview {
//    RitualUnitStatusBar()
//        .environmentObject(ListViewModel())
//}

extension View {
    @ViewBuilder
    private func onTapBackgroundContent(enabled: Bool, _ action: @escaping () -> Void) -> some View {
        if enabled {
            Color.clear
                .frame(width: UIScreen.main.bounds.width * 2, height: UIScreen.main.bounds.height * 2)
                .contentShape(Rectangle())
                .onTapGesture(perform: action)
        }
    }

    func onTapBackground(enabled: Bool, _ action: @escaping () -> Void) -> some View {
        background(
            onTapBackgroundContent(enabled: enabled, action)
        )
    }
}
