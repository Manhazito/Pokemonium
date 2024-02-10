//
//  ApiConfig.swift
//  Pokemonium
//
//  Created by Filipe Ramos on 09/02/2024.
//

import Foundation

public enum ApiConfig {
    static let elementsPerPage = 20
    
    // MARK: - Endpoints
    
    static private let pokemonBaseUrl = "https://pokeapi.co/api/v2"

    static func pokemonListUrl(page: Int) -> String {
        let offset = elementsPerPage * (page - 1)
        return pokemonBaseUrl + "/pokemon?limit=\(elementsPerPage)&offset=\(offset)"
    }
    static func pokemonDetailsUrl(_ name: String) -> String { pokemonBaseUrl + "/pokemon/\(name)" }
}
