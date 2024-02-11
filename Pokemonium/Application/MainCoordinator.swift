//
//  MainCoordinator.swift
//  Pokemonium
//
//  Created by Filipe Ramos on 10/02/2024.
//

import UIKit

open class MainCoordinator: NSObject, Coordinator {
    var children: [Coordinator] = []
    var parent: Coordinator?
    var rootViewController: UINavigationController?
    var currentCoordinator: Coordinator?
    
    init(rootViewController: UINavigationController?) {
        self.rootViewController = rootViewController
    }
    
    func push(child: Coordinator) {
        currentCoordinator?.stop()

        child.parent = self
        children.append(child)
        child.start()

        currentCoordinator = child
    }
    
    func start() { }
    
    func stop() {
        guard let parent = parent else {
            fatalError("\(self) has no parent and is probably leaking…")
        }
        
        guard let childIdx = parent.children.firstIndex(where: { $0 === self }) else { return }
        parent.children.remove(at: childIdx)
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
