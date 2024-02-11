//
//  PokemonData.swift
//  Pokemonium
//
//  Created by Filipe Ramos on 11/02/2024.
//

import Foundation

struct PokemonData: Hashable {
    let name: String
    let imageUrl: String
    let heightMeters: Double // meters
    let weightKg: Double // kg
    let experience: String
    let rarity: Int
    let species: String
    let type: PokemonType
}

extension PokemonData {
    var typeImage: String {
        "\(type.rawValue)_type"
    }
    var height: String {
        String(format: "%.2f m", heightMeters)
    }
    var weight: String {
        String(format: "%.2f", weightKg)
    }
}
