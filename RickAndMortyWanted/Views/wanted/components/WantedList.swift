//
//  WantedListView.swift
//  RickAndMortyWanted
//
//  Created by Iago on 08/07/23.
//

import SwiftUI

struct WantedList: View {
    var viewModel: WantedViewModel
    var onRefresh: () -> Void
    
    init(viewModel: WantedViewModel,onRefresh: @escaping ()->Void) {
        self.viewModel = viewModel
        self.onRefresh = onRefresh
    }
    
    var body: some View {List (viewModel.characters, id: \.id) { item in
        WantedListItem(character: item)
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
            .listRowSeparator(.hidden)
            .refreshable {
                onRefresh()
            }
    }
}
