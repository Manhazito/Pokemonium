//
//  PokemonRepositoryMock.swift
//  PokemoniumTests
//
//  Created by Filipe Ramos on 11/02/2024.
//

import Foundation
import Combine
@testable import Pokemonium

class PokemonRepositoryMock: PokemonRepository {
    
    override func getPokemons(page: Int) -> AnyPublisher<[PokemonListItem], Error> {
        Just([PokemonListItem(name: "testamon", url: ""),
              PokemonListItem(name: "testorium", url: ""),
              PokemonListItem(name: "testain", url: ""),
              PokemonListItem(name: "testum", url: "")])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    override func getPokemon(_ name: String) -> AnyPublisher<Pokemon, Error> {
        Just(Pokemon(id: 1,
                     name: "testamon",
                     baseExperience: 123,
                     height: 15,
                     weight: 25,
                     sprites: Sprites(frontDefault: ""),
                     types: [PokeTypeContainer(type: Named(name: "fire"))],
                     species: Named(name: "testamonium"),
                     heldItems: [HeldItem(versionDetails: [VersionDetails(rarity: 4)])]))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
