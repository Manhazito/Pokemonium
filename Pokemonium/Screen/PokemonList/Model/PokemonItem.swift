//
//  PokemonItem.swift
//  Pokemonium
//
//  Created by Filipe Ramos on 10/02/2024.
//

import UIKit

enum PokemonType: String {
    case ground
    case bug
    case dark
    case dragon
    case electric
    case fairy
    case fighting
    case fire
    case flying
    case ghost
    case grass
    case ice
    case normal
    case poison
    case psychic
    case rock
    case steel
    case water
    case unknown
}

struct PokemonItem: Hashable {
    let name: String
    let imageUrl: String
    let type: PokemonType
}

extension PokemonItem {
    var typeImage: String {
        "\(type.rawValue)_type"
    }
    
    var typeColor: UIColor {
        UIColor(named: "\(type.rawValue)Color") ?? .white
    }
}
