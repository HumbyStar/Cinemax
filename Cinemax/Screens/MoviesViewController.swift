//
//  ViewController.swift
//  Cinemax
//
//  Created by Humberto Rodrigues on 10/01/23 --> 1.00:48 minutos
//

import UIKit

final class MoviesViewController: UIViewController, UISearchBarDelegate { // Responsável por reenderizar a tela.

    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.tintColor = .white
        searchController.searchBar.barStyle = .black
        searchController.searchBar.delegate = self
        return searchController
    }()
    
    private lazy var backgroundImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "background")
        image.contentMode = .scaleToFill
        image.alpha = 0.4
        return image
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 200
        tableView.estimatedRowHeight = 150
        return tableView
    }()
    
    private var movies: [Movie]? {
        didSet{
            tableView.reloadData()
        }
    }
    private let service: MovieService = MovieService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewCode()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchMovies()
    }
    
    private func fetchMovies() {
        service.fetchList { [weak self] result in //MARK: Uso weak self para ter uma referencia fraca.
            switch result {
            case .success(let response):
                self?.movies = response
            case .failure: //MARK: posso passar somente .failure sem referenciar nenhum enum
                self?.movies = nil
            }
        }
    }
    
    private func searchMovies(name: String) {
        service.fetchResults(name) { [weak self] result in
            switch result {
            case .success(let response):
                self?.movies = response.compactMap({ $0.show}) // compactMap transformou searchShowElements em Movie
            case .failure:
                self?.movies = nil
                }
            }
        }
    
    
    func setupNavigation() {
        title = "Cinemax"
        navigationController?.navigationBar.prefersLargeTitles = true
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        navigationItem.searchController = searchController
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else { //MARK: Se nao estiver vazio de um fetchMovies() que chama a lista de filmes
            fetchMovies( )
            return
        }
        searchMovies(name: searchText)
        
    }


}

extension MoviesViewController: ViewCode {
    func setView() {
        view.addSubview(backgroundImage)
        view.addSubview(tableView)
    }
    
    func setContrains() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func extraChanges() {
        setupNavigation()
    }
    
}

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "cell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell
        let movie = movies?[indexPath.row]
        if let movie = movie {
            cell.configure(movie: movie)
        }
        return cell
    }
    
    
}

