//
//  LocationsViewModel.swift
//  RickAndMortyWanted
//
//  Created by Iago on 24/07/23.
//

import SwiftUI


class LocationsViewModel: ObservableObject {
    
    @Published var locations: [Dimension] = []
    @Published var locationsFiltered: [Dimension] = []
    private var currentPage = 1
    
    init() {
        print(213)
        getLocations()
    }
    
    func filterLocation(name: String){
        if(name.isEmpty){
            self.locationsFiltered =  locations
        }else{
            self.locationsFiltered =  locations.filter { dimension in
                dimension.locations.contains { location in
                    return location.name.lowercased().contains(name.lowercased())
                }
            }
        }
    }
    
    func getDimensions(locations : [Location]) -> [Dimension] {
        var dimensions: [Dimension] = []
        
        for item in locations {
            let dimension = item.dimension.isEmpty ? "unknown" : item.dimension
            
            if let existingDimensionIndex = dimensions.firstIndex(where: { $0.name == dimension }) {
                dimensions[existingDimensionIndex].locations.append(item)
            } else {
                dimensions.append(Dimension(name: dimension, locations: [item]))
            }
        }
        return dimensions
    }
    
    func appendLocations(locations: [Location]) {
        let newDimensions = self.getDimensions(locations: locations)
        
        for newDimension in newDimensions {
            if let existingDimensionIndex = self.locations.firstIndex(where: { $0.name == newDimension.name }) {
                self.locations[existingDimensionIndex].locations.append(contentsOf: newDimension.locations)
            } else {
                self.locations.append(newDimension)
            }
        }
    }
    
    func getLocations(loadMore: Bool = false) {
        self.currentPage = loadMore ?  self.currentPage + 1 : 1
        Api.request(endpoint: .LOCATION, type: ResponseList<Location>.self, queryParameters: [URLQueryItem(name: "page", value: String(self.currentPage))]) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    if(loadMore){
                        self.appendLocations(locations: data.results)
                    }else{
                        self.locations = self.getDimensions(locations: data.results)
                    }
                }
            case .failure(let error):
                print("Error:", error)
            }
        }
    }
}
