//
//  WantedViewModel.swift
//  RickAndMortyWanted
//
//  Created by Iago on 29/06/23.
//

import SwiftUI


class WantedViewModel: ObservableObject {
    
    @Published var characters: [Character] = []
    
    func getCharacters() {
        Api.request(endpoint: .CHARACTER, type: CharacterList.self) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.characters = data.results
                }
            case .failure(let error):
                print("Error:", error)
            }
        }
    }
}
