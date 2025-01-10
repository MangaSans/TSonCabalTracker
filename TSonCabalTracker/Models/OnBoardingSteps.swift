//
//  OnBoardingSteps.swift
//  TSonCabalTracker
//
//  Created by John Moyer on 12/10/24.
//

import Foundation
import SwiftUI

struct onBoardingSteps {
    let image: String
    let title: String
    let descrip: String
}

let onBoardingStrings = [
//    onBoardingSteps(image: "hello", title: "Add your first unit", descrip: "In this screen, you'll also be able to assign a unit equipped with Lord of Forbidden Lore or Athenaean Scrolls."),
    onBoardingSteps(image: "onBoarding1", title: "Helbrute and Tzaangor Abilities", descrip: "They will be located in the side bar menu. They will reset at your next turn."),
    onBoardingSteps(image: "onBoarding2", title: "Ahriman and Lord of Forbidden Lore Abilities", descrip: "In the Ritual Tab, you can tap the bottom bar to check if you can use these abilities."),
    onBoardingSteps(image: "onBoarding4", title: "Using Rituals", descrip: "Tap to enable the ritual, swipe left to use Ahriman's or Lord of Forbidden Lore's ability on said ritual."),
    onBoardingSteps(image: "onBoarding3", title: "Phases/Turns", descrip: "Tap the top bar on the Rituals tab to go to the next phase. Tap Next Turn if you've used up all your cabal points early.")
]
