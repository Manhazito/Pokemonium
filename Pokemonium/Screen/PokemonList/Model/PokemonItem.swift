//
//  PokemonItem.swift
//  Pokemonium
//
//  Created by Filipe Ramos on 10/02/2024.
//

import UIKit

struct PokemonItem: Hashable {
    let name: String
    let imageUrl: String
    let type: PokemonType
}

extension PokemonItem {
    var typeColor: UIColor {
        UIColor(named: "\(type.rawValue)Color") ?? .white
    }
}
