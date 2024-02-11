//
//  Pokemon.swift
//  Pokemonium
//
//  Created by Filipe Ramos on 09/02/2024.
//

import Foundation

struct Pokemon: Decodable {
    let id: Int
    let name: String
    let baseExperience: Int
    let height: Int // decimetres
    let weight: Int // hectograms
    let sprites: Sprites
    let types: [PokeTypeContainer]
    let species: Named
    let heldItems: [HeldItem]
}

struct Sprites: Decodable {
    let frontDefault: String
}

struct PokeTypeContainer: Decodable {
    let type: Named
}

struct HeldItem: Decodable {
    let versionDetails: [VersionDetails]
}

struct VersionDetails: Decodable {
    let rarity: Int
}

struct Named: Decodable {
    let name: String
}

extension Pokemon {
    var imageUrl: String {
        sprites.frontDefault
    }
    var weightKg: Double { Double(weight) / 10 }
    var heightMeters: Double { Double(height) / 10 }
}
