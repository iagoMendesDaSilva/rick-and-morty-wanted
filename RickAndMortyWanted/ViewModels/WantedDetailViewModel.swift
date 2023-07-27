//
//  WantedDetailViewModel.swift
//  RickAndMortyWanted
//
//  Created by Iago on 26/07/23.
//
import SwiftUI

class WantedDetailViewModel: ObservableObject {
    
    @Published var origin: Location?
    @Published var location: Location?
    
    func getIdLocation(url: String) -> String {
           guard let url = URL(string: url) else { return "1" }

           if let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) {
               if let lastPathComponent = urlComponents.path.split(separator: "/").last {
                   return String(lastPathComponent)
               }
           }
           return "1"
       }

    func getLocationInfo(url: String, origin: Bool){
        let id = self.getIdLocation(url: url)
        Api.request(endpoint: .LOCATION, type: Location.self, pathParam: id) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    if(origin){
                        self.origin = data
                    }else{
                        self.location = data
                    }
                }
            case .failure(let error):
                print("Error:", error)
            }
        }
    }
}
