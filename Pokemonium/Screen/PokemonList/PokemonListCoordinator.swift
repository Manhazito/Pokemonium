//
//  PokemonListCoordinator.swift
//  Pokemonium
//
//  Created by Filipe Ramos on 10/02/2024.
//

import UIKit

protocol PokemonListCoordinatorDelegate: AnyObject {
    func showError(_ error: Error, callback: @escaping () -> Void)
}

final class PokemonListCoordinator: MainCoordinator, PokemonListCoordinatorDelegate {
    
    init(parent: Coordinator) {
        super.init(rootViewController: parent.rootViewController)
    }
    
    override func start() {
        let repository = PokemonRepository()
        let presenter = PokemonListPresenter(coordinator: self, repository: repository)
        let viewController = PokemonListViewController.create(with: presenter)
        rootViewController?.pushViewController(viewController, animated: true)
    }
    
    func showError(_ error: Error, callback: @escaping () -> Void) {
        let title = "Something went wrong"
        let message = error.localizedDescription
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { _ in
            callback()
        }))

        rootViewController?.present(alert, animated: true)
    }
}
