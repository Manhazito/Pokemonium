//
//  PokemonListItemCellTableViewCell.swift
//  Pokemonium
//
//  Created by Filipe Ramos on 09/02/2024.
//

import UIKit
import Kingfisher

class PokemonListItemCellTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var pictureImageView: UIImageView! {
        didSet { pictureImageView.image = placeholderImage }
    }
    @IBOutlet weak var nameLabel: UILabel! {
        didSet { nameLabel.text = "" }
    }
    
    // MARK: - Private properties
    private let placeholderImage = UIImage(named: "pokeball_s")
    
    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Public functions
    func setup(with pokemonItem: PokemonItem) {
        backgroundColor = pokemonItem.typeColor
        nameLabel.text = pokemonItem.name.capitalized

        if let url = URL(string: pokemonItem.imageUrl) {
            pictureImageView.kf.setImage(
                with: url,
                placeholder: placeholderImage
            )
        }
    }
}
