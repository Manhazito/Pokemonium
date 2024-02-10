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
    let height: Int // hectograms
    let sprites: Sprites
    let types: [PokeTypeContainer]
}

struct Sprites: Decodable {
    let frontDefault: String
}

struct PokeTypeContainer: Decodable {
    let type: PokeType
}

struct PokeType: Decodable {
    let name: String
}

extension Pokemon {
    var imageUrl: String {
        sprites.frontDefault
    }
    
    var heightKg: Double { Double(height) / 10 }
}
