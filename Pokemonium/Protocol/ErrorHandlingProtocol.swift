//
//  ErrorHandlingProtocol.swift
//  Pokemonium
//
//  Created by Filipe Ramos on 11/02/2024.
//

import Foundation

protocol ErrorHandlingProtocol {
    func showError(_ error: Error, callback: @escaping () -> Void)
}
