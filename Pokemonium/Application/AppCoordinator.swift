//
//  AppCoordinator.swift
//  Pokemonium
//
//  Created by Filipe Ramos on 10/02/2024.
//

import UIKit

final class AppCoordinator: MainCoordinator {
    private let navController: UINavigationController
    
    init(navController: UINavigationController) {
        self.navController = navController
        super.init(rootViewController: self.navController)
    }
    
    override func start() {        
        showPokemonList()
    }
    
    private func showPokemonList() {
        let coordinator = PokemonListCoordinator(parent: self)
        push(child: coordinator)
    }
}
