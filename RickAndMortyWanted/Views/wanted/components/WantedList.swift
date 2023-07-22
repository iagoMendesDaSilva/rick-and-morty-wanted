//
//  WantedListView.swift
//  RickAndMortyWanted
//
//  Created by Iago on 08/07/23.
//

import SwiftUI

struct WantedList: View {
    var viewModel: WantedViewModel
    var isFiltered : Bool
    var onRefresh: () -> Void
    
    init(viewModel: WantedViewModel, isFiltered: Bool, onRefresh: @escaping ()->Void) {
        self.viewModel = viewModel
        self.isFiltered = isFiltered
        self.onRefresh = onRefresh
    }
    
    var body: some View {
        List (isFiltered ? viewModel.charactersFiltered : viewModel.characters, id: \.id) { item in
        WantedListItem(character: item)
                .listRowSeparator(.hidden)
            .listRowBackground(
                RoundedRectangle(cornerRadius: 10).background(.clear).foregroundColor(Color(UIColor.secondarySystemBackground)).padding(EdgeInsets(top: 5,leading: 10,bottom: 5,trailing: 10))
            )
            .listRowInsets(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            .onAppear(){
                if (self.viewModel.characters.last?.id == item.id){
                    self.viewModel.getCharacters(loadMore: true)
                }
            }
    }.listStyle(.plain)
            .refreshable {
                onRefresh()
            }
    }
}
