//
//  RecordsListItem.swift
//  RickAndMortyWanted
//
//  Created by Iago on 23/07/23.
//

import SwiftUI

struct RecordsListItem: View {
    var record: Episode
    var gradient: LinearGradient
    
    init(record: Episode, gradient: LinearGradient) {
        self.record = record
        self.gradient = gradient
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(systemName: "folder.fill")
                .font(.system(size: 150))
                .foregroundColor(.clear)
                .background(gradient)
                .mask(Image(systemName: "folder.fill").resizable().scaledToFit())
            VStack(alignment: .leading){
                Text(record.name)
                    .font(.headline)
                    .lineLimit(1)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .frame(width: 135, alignment: .leading)
                Text(record.air_date)
                    .font(.footnote)
                    .lineLimit(1)
                    .foregroundColor(.white)
                    .opacity(0.7)
                    .frame(width: 135, alignment: .leading)
            }.padding(15)
        }
    }
}
