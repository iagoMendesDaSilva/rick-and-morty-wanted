//
//  Endpoints.swift
//  RickAndMortyWanted
//
//  Created by Iago on 29/06/23.
//

import Foundation

@frozen enum Endpoints: String, CaseIterable, Hashable {
    case CHARACTER = "character"
    case LOCATION = "location"
    case EPISODE = "locations"
}
