//
//  PokemonRepository.swift
//  Pokemonium
//
//  Created by Filipe Ramos on 09/02/2024.
//

import Foundation
import Combine

protocol PokemonRepositoryProtocol {
    func getPokemonsList(page: Int) -> AnyPublisher<[PokemonItem], Error>
}

class PokemonRepository: PokemonRepositoryProtocol {
    
    func getPokemonsList(page: Int) -> AnyPublisher<[PokemonItem], Error> {
        getPokemons(page: page)
            .flatMap(getPokemons)
            .map { items in
                items.map { item in
                    PokemonItem(name: item.name, imageUrl: item.imageUrl, type: PokemonType(rawValue: item.types.first?.type.name ?? "") ?? .unknown)
                }
            }
            .eraseToAnyPublisher()
    }

    private func getPokemons(page: Int) -> AnyPublisher<[PokemonListItem], Error> {
        guard let url = URL(string: ApiConfig.pokemonListUrl(page: page)) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: PokemonList.self, decoder: JSONDecoder())
            .map { list in
                list.results
            }
            .eraseToAnyPublisher()
    }
    
    private func getPokemons(in items: [PokemonListItem]) -> AnyPublisher<[Pokemon], Error> {
        let publishers: [AnyPublisher<Pokemon, Error>] = items.map(getPokemon)
        
        return Publishers.MergeMany(publishers)
            .collect(publishers.count)
            .eraseToAnyPublisher()
    }
    
    private func getPokemon(_ item: PokemonListItem) -> AnyPublisher<Pokemon, Error> {
        guard let url = URL(string: ApiConfig.pokemonDetailsUrl(item.name)) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: Pokemon.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
