//
//  WantedView.swift
//  RickAndMortyWanted
//
//  Created by Iago on 29/06/23.
//

import SwiftUI

struct WantedView: View {

    @ObservedObject var viewModel = WantedViewModel()
    
    var body: some View {
        VStack {
            ForEach(viewModel.characters, id: \.id){ item in
                Text(item.name)
            }
        }.onAppear(perform: {
            viewModel.getCharacters()
        })
    }
}

struct WantedView_Previews: PreviewProvider {
    static var previews: some View {
        WantedView()
    }
}
