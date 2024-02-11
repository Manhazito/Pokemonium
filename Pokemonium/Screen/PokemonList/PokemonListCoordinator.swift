//
//  PokemonListCoordinator.swift
//  Pokemonium
//
//  Created by Filipe Ramos on 10/02/2024.
//

import UIKit

protocol PokemonListCoordinatorDelegate: AnyObject {
    func showPokemonDetails(for name: String)
}

final class PokemonListCoordinator: MainCoordinator, PokemonListCoordinatorDelegate, ErrorHandlingProtocol {
    
    init(parent: Coordinator) {
        super.init(rootViewController: parent.rootViewController)
    }
    
    override func start() {
        let repository = PokemonRepository()
        let presenter = PokemonListPresenter(coordinator: self, repository: repository)
        let viewController = PokemonListViewController.create(with: presenter)
        rootViewController?.pushViewController(viewController, animated: true)
    }
    
    func showPokemonDetails(for name: String) {
        let coordinator = PokemonDetailsCoordinator(parent: self, pokemonName: name)
        push(child: coordinator)
    }
}
