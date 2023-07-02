//
//  WantedView.swift
//  RickAndMortyWanted
//
//  Created by Iago on 29/06/23.
//

import SwiftUI

struct WantedView: View {
    
    @State private var search: String = ""
    @ObservedObject var viewModel = WantedViewModel()
    
    var body: some View {
        VStack{
            TextField("Search Wanted", text: $search).onChange(of: search){
                viewModel.filterCharacters(name: $0)
            }
            .padding()
            .background(Color(UIColor.secondarySystemBackground))
            .frame(maxWidth: .infinity, maxHeight: 40)
            .cornerRadius(10)
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            if(viewModel.characters.isEmpty && !search.isEmpty){
                Text("No Wanted Found")
                    .frame(maxWidth: .infinity,  maxHeight: .infinity, alignment: .center)
                    .foregroundColor(Color(UIColor.secondaryLabel))
            }else{
                WantedList(viewModel:viewModel, onRefresh: onRefresh)
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
    
    
    struct WantedView_Previews: PreviewProvider {
        static var previews: some View {
            WantedView()
        }
    }
    
}

