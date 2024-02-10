//
//  Coordinator.swift
//  Pokemonium
//
//  Created by Filipe Ramos on 10/02/2024.
//

import UIKit

protocol Coordinator: AnyObject {
    var children: [Coordinator] { get set }
    var parent: Coordinator? { get set }
    var rootViewController: UINavigationController? { get set }
    var currentCoordinator: Coordinator? { get set }

    func push(child: Coordinator)
    func start()
    func stop()
}
