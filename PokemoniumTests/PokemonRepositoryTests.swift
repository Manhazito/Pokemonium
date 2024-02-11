//
//  PokemonRepositoryTests.swift
//  PokemoniumTests
//
//  Created by Filipe Ramos on 08/02/2024.
//

import XCTest
import Combine
@testable import Pokemonium

final class PokemonRepositoryTests: XCTestCase {
    var bag = Set<AnyCancellable>()
    var repository: PokemonRepositoryProtocol?
    
    override func setUpWithError() throws {
        repository = PokemonRepositoryMock()
    }
    
    func testNumberOfItems() throws {
        let listPub = repository?.getPokemonsList(page: 0)
        
        let expectedNumberOfItemsSuccess = XCTestExpectation(description: "Got the correct number of items")
        
        listPub?.sink(receiveCompletion: { _ in
        }, receiveValue: { list in
            if list.count == 4 {
                expectedNumberOfItemsSuccess.fulfill()
            }
        })
        .store(in: &bag)
        
        wait(for: [expectedNumberOfItemsSuccess], timeout: 1)
    }
    
    func testItemType() throws {
        let listPub = repository?.getPokemonsList(page: 0)
        
        let expectedTypeSuccess = XCTestExpectation(description: "Got the correct type")
        
        listPub?.sink(receiveCompletion: { _ in
        }, receiveValue: { list in
            if list[0].type == .fire {
                expectedTypeSuccess.fulfill()
            }
        })
        .store(in: &bag)
        
        wait(for: [expectedTypeSuccess], timeout: 1)
    }
    
    func testItemName() throws {
        let listPub = repository?.getPokemonsList(page: 0)
        
        let expectedTypeSuccess = XCTestExpectation(description: "Got the correct type")
        
        listPub?.sink(receiveCompletion: { _ in
        }, receiveValue: { list in
            if list[0].name == "testamon" {
                expectedTypeSuccess.fulfill()
            }
        })
        .store(in: &bag)
        
        wait(for: [expectedTypeSuccess], timeout: 1)
    }
    
    func testPokemonHeight() throws {
        let pokePub = repository?.getPokemon(named: "")
        
        let expectedHeightSuccess = XCTestExpectation(description: "Got the correct height")
        
        pokePub?.sink(receiveCompletion: { _ in
        }, receiveValue: { pokemon in
            if pokemon.height == "1.50 m" {
                expectedHeightSuccess.fulfill()
            }
        })
        .store(in: &bag)
        
        wait(for: [expectedHeightSuccess], timeout: 1)
    }
    
    func testPokemonWeight() throws {
        let pokePub = repository?.getPokemon(named: "")
        
        let expectedWeightSuccess = XCTestExpectation(description: "Got the correct weight")

        pokePub?.sink(receiveCompletion: { _ in
        }, receiveValue: { pokemon in
            if pokemon.weight == "2.50" {
                expectedWeightSuccess.fulfill()
            }
        })
        .store(in: &bag)
        
        wait(for: [expectedWeightSuccess], timeout: 1)
    }
}
