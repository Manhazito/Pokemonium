//
//  PokemonDetailsCoordinator.swift
//  Pokemonium
//
//  Created by Filipe Ramos on 11/02/2024.
//

import Foundation

final class PokemonDetailsCoordinator: MainCoordinator, ErrorHandlingProtocol {
    
    private var pokemonName: String
    
    init(parent: Coordinator, pokemonName: String) {
        self.pokemonName = pokemonName
        super.init(rootViewController: parent.rootViewController)
    }
    
    override func start() {
        let repository = PokemonRepository()
        let presenter = PokemonDetailsPresenter(coordinator: self, repository: repository, pokemonName: pokemonName)
        let viewController = PokemonDetailsViewController.create(with: presenter)
        rootViewController?.pushViewController(viewController, animated: true)
    }
}
