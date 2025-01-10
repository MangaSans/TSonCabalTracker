//
//  OnBoardingView.swift
//  TSonCabalTracker
//
//  Created by John Moyer on 10/30/24.
//

import SwiftUI

//struct onBoardingSteps {
//    let image: String
//    let title: String
//    let descrip: String
//}
//
//private let onBoardingStrings = [
//    onBoardingSteps(image: "hello", title: "hi again", descrip: "hey there"),
//    onBoardingSteps(image: "sup", title: "how you doin", descrip: "whats poppin"),
//    onBoardingSteps(image: "cya", title: "goodbye", descrip: "farewell")
//]


struct OnBoardingView: View {
    @State var currentStep = 0
    @Environment(\.colorScheme) private var colorScheme
    
    init() {
        UIScrollView.appearance().bounces = false
    }
    
    
    var body: some View {
        VStack {   
            HStack {
                Spacer()
                Button(action: {
                    BottomBarViewer().userOnboarded = true
                }, label: {
                    Text("Skip")
                        .foregroundStyle(colorScheme == .light ? Color.white : Color.white)
                })
                .padding()
            }
            
            TabView (selection: $currentStep) {
                
                ForEach(0..<onBoardingStrings.count) { it in
                    VStack {
                        
                        Image(onBoardingStrings[it].image)
                            .resizable()
                            .frame(width: 200, height: 200)
                        Text(onBoardingStrings[it].title)
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .bold()
                            .multilineTextAlignment(.center)
                            .underline()
                        Text(onBoardingStrings[it].descrip)
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .padding(.top)
                    }
                    .tag(it)
                }
                .padding()
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            HStack {
                ForEach(0..<onBoardingStrings.count) { it in
                    if it == currentStep {
                        RoundedRectangle(cornerRadius: 10.0)
                            .frame(width: 20, height: 10)
                            .foregroundStyle(Color.screamerPink)
                    } else {
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundStyle(Color.gray)
                    }
                }
            }
//            .animation(.easeInOut(duration: 0.2), value: currentStep)
            
            Button(action: {
                if self.currentStep < onBoardingStrings.count - 1 {
                    self.currentStep += 1
                } else {
                    BottomBarViewer().userOnboarded = true
                }
            }, label: {
                Text(currentStep < onBoardingStrings.count - 1 ? "Next" : "Get Started")
                    .padding(16)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .background(Color.screamerPink)
                    .clipShape(Capsule.capsule(style: .continuous))
                    .foregroundStyle((Color.white))
                    .padding(.vertical)
            })
            .buttonStyle(PlainButtonStyle())
        }
        .frame(maxHeight: 575)
    }
}

#Preview {
    OnBoardingView()
}
