//
//  WhyNoAdsView.swift
//  TSonCabalTracker
//
//  Created by John Moyer on 5/5/24.
//

import SwiftUI

struct WhyNoAdsView: View {
    var body: some View {
        NavigationStack {
            Text("You Hate Ads, I Hate Ads.")
                .fontWeight(.heavy)
                .padding()
            Text("I hate being forced to watch ads, so subjecting someone else to them for a quick buck seems hypocritical.\n\nI'm also at the mercy of Games Workshop whether these rules will persist into the next edition. So it didn't make any sense to charge for an app that could be made obsolete in a new edition or rules change either.\n\nSo, I'm keeping the app free to use. The only thing I ask in return is if you find a problem, please report it so it can be fixed quickly.")
                .padding()
        }
        .padding()
        .frame(width: 400)
    }
}

#Preview {
    NavigationStack{
        WhyNoAdsView()
    }
}
