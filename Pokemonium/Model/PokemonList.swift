//
//  PokemonList.swift
//  Pokemonium
//
//  Created by Filipe Ramos on 09/02/2024.
//

import Foundation

struct PokemonList: Decodable {
    let count: Int
    let results: [PokemonListItem]
}
