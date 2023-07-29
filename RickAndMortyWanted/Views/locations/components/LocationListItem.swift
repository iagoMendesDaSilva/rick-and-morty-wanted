//
//  LocationListItem.swift
//  RickAndMortyWanted
//
//  Created by Iago on 24/07/23.
//

import SwiftUI

struct LocationListItem: View {
    
    var location: Location
    var gradient: LinearGradient
    
    init(location: Location, gradient: LinearGradient) {
        self.location = location
        self.gradient = gradient
    }
    
    var body: some View {
        ZStack(alignment: .center){
            ZStack(alignment: .bottomLeading) {
                Rectangle()
                    .foregroundColor(.clear)
                    .background(gradient)
                    .cornerRadius(20)
                    .frame(width: 200, height: 200)
                VStack(alignment: .leading){
                    Text(location.name)
                        .font(.headline)
                        .lineLimit(1)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .frame(width: 150, alignment: .leading)
                    Text(LocalizedStringKey(location.type))
                        .font(.footnote)
                        .lineLimit(1)
                        .foregroundColor(.white)
                        .opacity(0.7)
                        .frame(width: 150, alignment: .leading)
                }.padding(15)
            }
            Image(location.type)
                .resizable()
                .frame(width: 100, height: 100)
                .aspectRatio(contentMode: .fit)
                .padding(EdgeInsets(top: 0,leading: 0,bottom: 35,trailing: 0))
        }
    }
}
