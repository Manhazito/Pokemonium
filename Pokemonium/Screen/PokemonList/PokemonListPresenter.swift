//
//  PokemonListPresenter.swift
//  Pokemonium
//
//  Created by Filipe Ramos on 10/02/2024.
//

import Foundation
import Combine

protocol PokemonListPresenterDelegate: AnyObject {
    var presenter: PokemonListViewDelegate? { get set }
    func refreshPokemonList(with pokemonList: [PokemonItem])
}

class PokemonListPresenter: Coordinated, PokemonListViewDelegate {
    var coordinator: Coordinator?
    weak var delegate: PokemonListPresenterDelegate?
    
    private var repository: PokemonRepositoryProtocol
    private var bag = Set<AnyCancellable>()
    
    private var pokemons: [PokemonItem] = []
    private var page = 1
    private var loading = false

    init(coordinator: Coordinator, repository: PokemonRepositoryProtocol) {
        self.coordinator = coordinator
        self.repository = repository
        self.fetchData()
    }
    
    // MARK: - Private functions
    
    private func fetchData() {
        self.loading = true
        
        repository.getPokemonsList(page: page)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case let .failure(error) = completion {
                    self.loading = false
                    (self.coordinator as? PokemonListCoordinatorDelegate)?.showError(error) {
                        self.fetchData()
                    }
                }
            } receiveValue: { pokemonList in
                self.pokemons.append(contentsOf: pokemonList)
                self.delegate?.refreshPokemonList(with: self.pokemons)
                self.loading = false
            }
            .store(in: &bag)
    }
    
    // MARK: - PokemonListViewDelegate
    
    func willDisplay(row: Int) {
        let lastRow = self.page * ApiConfig.elementsPerPage - 1
        
        if row == lastRow {
            self.page += 1
            self.fetchData()
        }
    }
    
    func fill(cell: PokemonListItemCellTableViewCell, with pokemonItem: PokemonItem) {
        cell.setup(with: pokemonItem)
    }
}
