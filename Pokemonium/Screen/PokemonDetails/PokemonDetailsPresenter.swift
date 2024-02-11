//
//  PokemonDetailsPresenter.swift
//  Pokemonium
//
//  Created by Filipe Ramos on 11/02/2024.
//

import Foundation
import Combine

protocol PokemonDetailsPresenterDelegate: AnyObject {
    var presenter: PokemonDetailsViewDelegate? { get set }
    func showDetails(for pokemon: PokemonData)
}

class PokemonDetailsPresenter: Coordinated, PokemonDetailsViewDelegate {
    var coordinator: Coordinator?
    weak var delegate: PokemonDetailsPresenterDelegate?

    private lazy var errorHandlingDelegate: ErrorHandlingProtocol? = self.coordinator as? ErrorHandlingProtocol

    private var pokemonName: String
    private var pokemonData: PokemonData?
    private var repository: PokemonRepositoryProtocol
    private var bag = Set<AnyCancellable>()

    // MARK: - Init

    init(coordinator: Coordinator, repository: PokemonRepositoryProtocol, pokemonName: String) {
        self.coordinator = coordinator
        self.repository = repository
        self.pokemonName = pokemonName
        self.fetchData()
    }
    
    // MARK: - Private functions
    
    private func fetchData() {
        repository.getPokemon(named: pokemonName)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case let .failure(error) = completion {
                    self.errorHandlingDelegate?.showError(error) {
                        self.fetchData()
                    }
                }
            } receiveValue: { pokemonData in
                self.pokemonData = pokemonData
                self.delegate?.showDetails(for: pokemonData)
            }
            .store(in: &bag)
    }
    
    // MARK: - PokemonDetailsViewDelegate functions

    func getRarityStarsVisibility() -> [Bool] {
        let nVisible = (pokemonData?.rarity ?? 1) - 1
        let nHidden = 4 - nVisible
        var visibilityArray = [Bool](repeating: true, count: nVisible)
        visibilityArray.append(contentsOf: [Bool](repeating: false, count: nHidden))

        return visibilityArray
    }
}
