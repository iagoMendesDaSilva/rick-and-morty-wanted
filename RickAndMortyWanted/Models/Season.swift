//
//  Season.swift
//  RickAndMortyWanted
//
//  Created by Iago on 22/07/23.


import Foundation

struct Season: Codable {
    let id: Int
    var episodes: [Episode]
}
