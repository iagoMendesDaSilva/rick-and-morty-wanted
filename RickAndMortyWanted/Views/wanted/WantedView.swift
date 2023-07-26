//
//  WantedView.swift
//  RickAndMortyWanted
//
//  Created by Iago on 29/06/23.
//

import SwiftUI

struct WantedView: View {
    
    @State private var search: String = ""
    @EnvironmentObject var viewModel: WantedViewModel
    
    var body: some View {
        VStack{
            Search(placeHolder: "Search Wanted",search: $search, onPress: { name in
                viewModel.filterCharacters(name: name)
            })
            if(viewModel.charactersFiltered.isEmpty && !search.isEmpty){
                Text("No Wanted Found")
                    .frame(maxWidth: .infinity,  maxHeight: .infinity, alignment: .center)
                    .foregroundColor(Color(UIColor.secondaryLabel))
            }else{
                WantedList(viewModel:viewModel,isFiltered: !search.isEmpty, onRefresh: onRefresh)
            }
        }.frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
          )
    }
    
    func onRefresh(){
        search = ""
        viewModel.getCharacters()
    }
    
}
