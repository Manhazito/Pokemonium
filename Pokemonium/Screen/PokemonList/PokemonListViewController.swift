//
//  PokemonListViewController.swift
//  Pokemonium
//
//  Created by Filipe Ramos on 08/02/2024.
//

import UIKit

protocol PokemonListViewDelegate: AnyObject {
    var delegate: PokemonListPresenterDelegate? { get set }
    func fill(cell: PokemonListItemCellTableViewCell, with pokemonItem: PokemonItem)
    func willDisplay(row: Int)
}

class PokemonListViewController: UITableViewController, PokemonListPresenterDelegate {
    var presenter: PokemonListViewDelegate?
    var repository: PokemonRepositoryProtocol?
    
    private lazy var dataSource: UITableViewDiffableDataSource<Int, PokemonItem> = makeDataSource()

    internal static func create(with presenter: PokemonListViewDelegate) -> PokemonListViewController {
        let viewController: PokemonListViewController = UIStoryboard(name: "PokemonList", bundle: nil).instantiateViewController(identifier: "PokemonList")
        presenter.delegate = viewController
        viewController.presenter = presenter
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTable()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Private functions

    private func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PokemonListItemCellTableViewCell", bundle: nil), forCellReuseIdentifier: "PokemonListItemCellTableViewCell")
    }
    
    private func makeDataSource() -> UITableViewDiffableDataSource<Int, PokemonItem> {
        UITableViewDiffableDataSource(tableView: tableView) { [weak self] tableView, indexPath, data in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(PokemonListItemCellTableViewCell.self)", for: indexPath) as? PokemonListItemCellTableViewCell else {
                return UITableViewCell()
            }
            
            self?.presenter?.fill(cell: cell, with: data)
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        presenter?.willDisplay(row: indexPath.row)
    }
    
    // MARK: - PokemonListPresenterDelegate
    
    func refreshPokemonList(with pokemonList: [PokemonItem]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, PokemonItem>()
        snapshot.appendSections([0])
        snapshot.appendItems(pokemonList)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
