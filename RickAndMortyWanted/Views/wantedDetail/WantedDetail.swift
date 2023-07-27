//
//  WantedDetail.swift
//  RickAndMortyWanted
//
//  Created by Iago on 26/07/23.
//

import SwiftUI

struct WantedDetail: View {
    var character: Character
    @ObservedObject private var viewModel : WantedDetailViewModel = WantedDetailViewModel()
    
    init(character: Character) {
        self.character = character
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                AsyncImage(url: URL(string: self.character.image)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: 400)
                        .cornerRadius(20)
                        .padding(.bottom, 10)
                }placeholder: {
                    ProgressView().frame(width: 125, height: 125)
                        .progressViewStyle(.circular).tint(Color(UIColor.systemFill))
                }
                Text(character.name).font(.title).fontWeight(.bold).lineLimit(1)
                Text(character.species).font(.headline).fontWeight(.medium).foregroundColor(Color(UIColor.secondaryLabel))
                    .padding(.vertical, 10)
                    .padding(.horizontal, 25)
                    .lineLimit(1)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(100)
                HStack(alignment: .center, spacing: 0){
                    if(viewModel.origin != nil && viewModel.location != nil){
                        LocationDetail(title: "Origin", location: viewModel.origin!)
                        LocationDetail(title: "Last Seen", location: viewModel.location!)
                    }
                }.onAppear{
                    self.viewModel.getLocationInfo(url: self.character.origin.url, origin: true)
                    self.viewModel.getLocationInfo(url: self.character.location.url, origin: false)
                }
            }.edgesIgnoringSafeArea(.all)
        }
    }
}
