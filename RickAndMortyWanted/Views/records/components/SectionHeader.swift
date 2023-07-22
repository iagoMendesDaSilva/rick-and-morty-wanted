//
//  SectionHeader.swift
//  RickAndMortyWanted
//
//  Created by Iago on 23/07/23.
//

import SwiftUI

struct SectionHeader: View {
    var season: Int
    
    init(season: Int) {
        self.season = season
    }
    
    var body: some View {
        HStack {
            Text("Season").font(.title3).fontWeight(.bold).foregroundColor(Color(UIColor.label)).textCase(.none)
            Text(String(season)).font(.title3).foregroundColor(Color(UIColor.secondaryLabel))
        }
    }
}
