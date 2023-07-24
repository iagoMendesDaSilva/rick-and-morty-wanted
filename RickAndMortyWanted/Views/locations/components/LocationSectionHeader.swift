//
//  LocationSectionHeader.swift
//  RickAndMortyWanted
//
//  Created by Iago on 24/07/23.
//

import SwiftUI

struct LocationSectionHeader: View {
    var dimensionName: String
    
    init(dimensionName: String) {
        self.dimensionName = dimensionName
    }
    
    var body: some View {
        HStack {
            Text(dimensionName.prefix(1).capitalized + dimensionName.dropFirst())
                .font(.title3).fontWeight(.bold).foregroundColor(Color(UIColor.label)).textCase(.none)
        }
    }
}
