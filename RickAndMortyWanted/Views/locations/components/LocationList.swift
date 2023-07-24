//
//  LocationList.swift
//  RickAndMortyWanted
//
//  Created by Iago on 24/07/23.
//

import SwiftUI

struct LocationList: View {
    var viewModel: LocationsViewModel
    var isFiltered: Bool
    var onRefresh: () -> Void
    
    init(viewModel: LocationsViewModel,isFiltered: Bool, onRefresh: @escaping ()->Void) {
        self.viewModel = viewModel
        self.isFiltered = isFiltered
        self.onRefresh = onRefresh
    }
    
    func verifyEndList(for item: Dimension) {
        if viewModel.locations.last?.name == item.name {
            viewModel.getLocations(loadMore: true)
        }
    }
    
    func gradientIndex( locationType: String) -> Int {
        guard let type = DimensionType(rawValue: locationType) else {
            return 0
        }
        let index = type.rawValue.hashValue % ColorService.gradients.count
        return index >= 0 ? index : -index
    }
    
    var body: some View {
        let locations = isFiltered ? viewModel.locationsFiltered : viewModel.locations
        List(locations.indices, id: \.self) { index in
            Section(header: LocationSectionHeader(dimensionName: locations[index].name)) {
                ZStack(alignment: .bottomTrailing){
                ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            if(!viewModel.locations.isEmpty){
                                ForEach(locations[index].locations.indices, id: \.self) { indexLocation in
                                    let item = locations[index].locations[indexLocation]
                                    LocationListItem(location: item, gradient: ColorService.gradients[gradientIndex(locationType: item.type)])
                                }
                            }
                        }.frame(height: 200)
                            .onAppear(){
                                self.verifyEndList(for: locations[index])
                            }
                    }
                    Rectangle().fill(LinearGradient(gradient: Gradient(colors: [Color(UIColor.systemBackground), .clear]), startPoint: .trailing, endPoint: .leading)).frame(width: 75, height: .infinity)
                }
            }.listRowSeparator(.hidden)
        }.listStyle(.plain)
            .refreshable {
                onRefresh()
                self.verifyEndList(for: viewModel.locations.last!)
            }
    }
}
