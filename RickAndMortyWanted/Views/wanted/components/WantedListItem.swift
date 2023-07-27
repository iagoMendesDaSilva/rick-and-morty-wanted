//
//  WantedItemView.swift
//  RickAndMortyWanted
//
//  Created by Iago on 08/07/23.
//

import SwiftUI

struct WantedListItem: View {
    var character: Character
    
    init(character: Character) {
        self.character = character
    }
    
    var body: some View {
        ZStack(alignment: .leading){
            HStack(alignment: .top){
                AsyncImage(
                    url: URL(string: character.image),
                    content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 125, height: 125)
                            .cornerRadius(10)
                    },
                    placeholder: {
                        ProgressView().frame(width: 125, height: 125)
                            .progressViewStyle(.circular).tint(Color(UIColor.systemFill))
                    }
                )
                VStack(alignment: .leading){
                    Text(character.name).font(.title2).fontWeight(.bold)
                    LabelInfo(text: character.species, icon: "person.fill")
                    LabelInfo(text: character.origin.name, icon: "globe.americas.fill")
                    LabelInfo(text: character.location.name, icon: "location.fill")
                }.padding()
            }
            NavigationLink(destination: WantedDetail(character: self.character)){}.buttonStyle(.plain).opacity(0)
            
        }
    }
}

struct LabelInfo: View {
    var text: String
    var icon: String
    
    init(text: String, icon: String) {
        self.text = text
        self.icon = icon
    }
    
    var body: some View {
        Label(text, systemImage:icon)
            .labelStyle(.titleAndIcon)
            .lineLimit(1)
            .foregroundColor(Color(UIColor.secondaryLabel))
    }
}
