//
//  WantedViewModel.swift
//  RickAndMortyWanted
//
//  Created by Iago on 29/06/23.
//

import SwiftUI


class WantedViewModel: ObservableObject {
    
    @Published var characters: [Character] = []
    @Published var charactersFiltered: [Character] = []
    private var currentPage = 1
    
    init() {
        getCharacters()
    }
    
    func filterCharacters(name: String){
        if(name.isEmpty){
            self.charactersFiltered =  characters
        }else{
            self.charactersFiltered =  characters.filter { $0.name.lowercased().contains(name.lowercased()) }
        }
    }

    func getCharacters(loadMore: Bool = false) {
        self.currentPage = loadMore ?  self.currentPage + 1 : 1
        Api.request(endpoint: .CHARACTER, type: ResponseList<Character>.self, queryParameters: [URLQueryItem(name: "page", value: String(self.currentPage))]) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    if(loadMore){
                        self.characters += data.results
                    }else{
                        self.characters = data.results
                    }
                }
            case .failure(let error):
                print("Error:", error)
            }
        }
    }
}
