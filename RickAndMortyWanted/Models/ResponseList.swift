//
//  CharacterList.swift
//  RickAndMortyWanted
//
//  Created by Iago on 29/06/23.
//

import Foundation

struct ResponseList<T: Codable>: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }

    let info: Info
    let results: [T]
}
