//
//  LocationDetail.swift
//  RickAndMortyWanted
//
//  Created by Iago on 27/07/23.
//

import SwiftUI

struct LocationDetail: View {
    var title: LocalizedStringKey
    var location: Location
    
    init(title: LocalizedStringKey, location: Location) {
        self.title = title
        self.location = location
    }
    
    let sizeItem = UIScreen.main.bounds.width * 0.45
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text(title).foregroundColor(Color(UIColor.secondaryLabel))
                ZStack(alignment: .center){
                    ZStack(alignment: .bottomLeading) {
                        Rectangle()
                            .foregroundColor(.clear)
                            .background(ColorService.gradientByDimensionType(locationType: location.type))
                            .cornerRadius(20)
                            .frame(width: sizeItem, height: sizeItem)
                        VStack(alignment: .leading){
                            Text(location.name)
                                .font(.headline)
                                .lineLimit(1)
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .frame(width: sizeItem-50, alignment: .leading)
                            Text(LocalizedStringKey(location.type))
                                .font(.footnote)
                                .lineLimit(1)
                                .foregroundColor(.white)
                                .opacity(0.7)
                                .frame(width: sizeItem-50, alignment: .leading)
                        }.padding(15)
                    }
                    Image(location.type)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 0.4 * sizeItem, height: 0.4 * sizeItem)
                        .padding(EdgeInsets(top: 0,leading: 0,bottom: 35,trailing: 0))
                }
            }.padding()
        }
    }
}
