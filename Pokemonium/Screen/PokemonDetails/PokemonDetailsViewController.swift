//
//  PokemonDetailsViewController.swift
//  Pokemonium
//
//  Created by Filipe Ramos on 11/02/2024.
//

import UIKit

protocol PokemonDetailsViewDelegate: AnyObject {
    var delegate: PokemonDetailsPresenterDelegate? { get set }
    func getRarityStarsVisibility() -> [Bool]
}

class PokemonDetailsViewController: UIViewController, PokemonDetailsPresenterDelegate {
    
    var presenter: PokemonDetailsViewDelegate?

    //MARK: - IBOutlets
    
    @IBOutlet weak private var pokemonNameLabel: UILabel! {
        didSet { pokemonNameLabel.text = "" }
    }
    @IBOutlet weak private var pokemonImageView: UIImageView! {
       didSet { pokemonImageView.image = placeholderImage }
    }
    @IBOutlet weak private var pokemonHeightLabel: UILabel! {
        didSet { pokemonHeightLabel.text = "" }
    }
    @IBOutlet weak private var pokemonWeightLabel: UILabel! {
        didSet { pokemonWeightLabel.text = "" }
    }
    
    @IBOutlet weak private var rarityStar2ImageView: UIImageView! {
        didSet { rarityStar2ImageView.isHidden = true }
    }
    @IBOutlet weak private var rarityStar3ImageView: UIImageView! {
        didSet { rarityStar3ImageView.isHidden = true }
    }
    @IBOutlet weak private var rarityStar4ImageView: UIImageView! {
        didSet { rarityStar4ImageView.isHidden = true }
    }
    @IBOutlet weak private var rarityStar5ImageView: UIImageView! {
        didSet { rarityStar5ImageView.isHidden = true }
    }
    
    @IBOutlet weak private var experienceLabel: UILabel! {
        didSet { experienceLabel.text = "" }
    }
    @IBOutlet weak private var speciesLabel: UILabel! {
        didSet { speciesLabel.text = "" }
    }
    @IBOutlet weak private var typeImageView: UIImageView! {
        didSet { typeImageView.isHidden = true }
    }
    
    // MARK: - Private properties
    
    private let placeholderImage = UIImage(named: "pokeball_s")
    private lazy var starsArray: [UIImageView] = [rarityStar2ImageView, rarityStar3ImageView, rarityStar4ImageView, rarityStar5ImageView]

    // MARK: - Initialization
    
    internal static func create(with presenter: PokemonDetailsViewDelegate) -> PokemonDetailsViewController {
        let viewController: PokemonDetailsViewController = UIStoryboard(name: "PokemonDetails", bundle: nil).instantiateViewController(identifier: "PokemonDetails")
        presenter.delegate = viewController
        viewController.presenter = presenter
        return viewController
    }

    // MARK: - PokemonDetailsPresenterDelegate

    func showDetails(for pokemon: PokemonData) {
        if let url = URL(string: pokemon.imageUrl) {
            pokemonImageView.kf.setImage(
                with: url,
                placeholder: placeholderImage
            )
        }

        pokemonNameLabel.text = pokemon.name.capitalized
        pokemonHeightLabel.text = pokemon.height
        pokemonWeightLabel.text = pokemon.weight
        experienceLabel.text = pokemon.experience
        speciesLabel.text = pokemon.species.capitalized
        typeImageView.image = UIImage(named: pokemon.typeImage)
        typeImageView.isHidden = false
        
        manageRarityStars()
    }

    // MARK: - Private functions

    private func manageRarityStars() {
        guard let starsVisibilityArray = presenter?.getRarityStarsVisibility() else { return }
        guard starsVisibilityArray.count == starsArray.count else { return }
        
        starsArray.indices.forEach { idx in
            starsArray[idx].isHidden = !starsVisibilityArray[idx]
        }
    }
}
