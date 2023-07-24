//
//  LocationsView.swift
//  RickAndMortyWanted
//
//  Created by Iago on 29/06/23.
//

import SwiftUI

struct LocationsView: View {
    
    @State private var search: String = ""
    @ObservedObject var viewModel = LocationsViewModel()
    
    var body: some View {
        VStack{
            Search(placeHolder: "Search Locations",search: $search, onPress: { name in
                viewModel.filterLocation(name: name)
            })
            if(viewModel.locationsFiltered.isEmpty && !search.isEmpty){
                Text("No Location Found")
                    .frame(maxWidth: .infinity,  maxHeight: .infinity, alignment: .center)
                    .foregroundColor(Color(UIColor.secondaryLabel))
            }else{
                LocationList(viewModel:viewModel,isFiltered: !search.isEmpty, onRefresh: onRefresh)
            }
        }.frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        )
    }
    
    func onRefresh(){
        search = ""
        viewModel.getLocations()
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
    }
}
