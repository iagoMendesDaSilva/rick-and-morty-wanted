//
//  RecordsViewModel.swift
//  RickAndMortyWanted
//
//  Created by Iago on 22/07/23.
//

import SwiftUI


class RecordsViewModel: ObservableObject {
    
    @Published var records: [Season] = []
    @Published var recordsFiltered: [Season] = []
    private var currentPage = 1
    
    init() {
        getRecords()
    }
    
    func filterRecord(name: String){
        if(name.isEmpty){
            self.recordsFiltered =  records
        }else{
            self.recordsFiltered =  records.filter { season in
                season.episodes.contains { episode in
                    return episode.name.lowercased().contains(name.lowercased())
                }
            }
        }
    }
    
    
    func getSeason(episodeName: String) -> Int {
        let season = String(episodeName.prefix(3).dropFirst())
        return Int(season) ?? 0
    }
    
    func getSeasons(episodes : [Episode]) -> [Season] {
        var seasons: [Season] = []
        
        for item in episodes {
            let season = self.getSeason(episodeName: item.episode)
            
            if let existingSeasonIndex = seasons.firstIndex(where: { $0.id == season }) {
                seasons[existingSeasonIndex].episodes.append(item)
            } else {
                seasons.append(Season(id: season, episodes: [item]))
            }
        }
        return seasons
    }
    
    func appendSeasons(episodes: [Episode]) {
        let newSeasons = self.getSeasons(episodes: episodes)
        
        for newSeason in newSeasons {
            if let existingSeasonIndex = self.records.firstIndex(where: { $0.id == newSeason.id }) {
                self.records[existingSeasonIndex].episodes.append(contentsOf: newSeason.episodes)
            } else {
                self.records.append(newSeason)
            }
        }
    }

    
    
    func getRecords(loadMore: Bool = false) {
        self.currentPage = loadMore ?  self.currentPage + 1 : 1
        Api.request(endpoint: .EPISODE, type: ResponseList<Episode>.self, queryParameters: [URLQueryItem(name: "page", value: String(self.currentPage))]) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    if(loadMore){
                        self.appendSeasons(episodes: data.results)
                    }else{
                        self.records = self.getSeasons(episodes: data.results)
                    }
                }
            case .failure(let error):
                print("Error:", error)
            }
        }
    }
}
