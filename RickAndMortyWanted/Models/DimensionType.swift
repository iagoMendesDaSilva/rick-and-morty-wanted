//
//  DimensionType.swift
//  RickAndMortyWanted
//
//  Created by Iago on 24/07/23.
//

import Foundation

enum DimensionType: String, CaseIterable, Codable  {
    case planet = "Planet"
    case cluster = "Cluster"
    case spaceStation = "Space station"
    case microverse = "Microverse"
    case tv = "TV"
    case resort = "Resort"
    case fantasyTown = "Fantasy town"
    case dream = "Dream"
    case dimension = "Dimension"
    case unknown = "unknown"
    case menagerie = "Menagerie"
    case game = "Game"
    case customs = "Customs"
    case daycare = "Daycare"
    case dwarfPlanet = "Dwarf planet (Celestial Dwarf)"
    case miniverse = "Miniverse"
    case teenyverse = "Teenyverse"
    case box = "Box"
    case spacecraft = "Spacecraft"
    case artificiallyGeneratedWorld = "Artificially generated world"
    case machine = "Machine"
    case arcade = "Arcade"
    case spa = "Spa"
    case quadrant = "Quadrant"
    case quasar = "Quasar"
    case mount = "Mount"
    case liquid = "Liquid"
    case convention = "Convention"
    case woods = "Woods"
    case diegesis = "Diegesis"
    case nonDiegeticAlternativeReality = "Non-Diegetic Alternative Reality"
    case nightmare = "Nightmare"
    case asteroid = "Asteroid"
    case acidPlant = "Acid Plant"
    case reality = "Reality"
    case deathStar = "Death Star"
    case base = "Base"
    case elementalRings = "Elemental Rings"
    case human = "Human"
    case space = "Space"
    case hell = "Hell"
    case policeDepartment = "Police Department"
    case country = "Country"
    case consciousness = "Consciousness"
    case memory = "Memory"
    
    static var count: Int {
        return allCases.count
    }
}
