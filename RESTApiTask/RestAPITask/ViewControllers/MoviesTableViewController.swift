//
//  NewMoviesTableViewController.swift
//  RESTApiTask
//
//  Created by Богдан Бакун on 01.06.2023.
//

import UIKit

class MoviesTableViewController: UITableViewController/*, UITableViewDataSourcePrefetching*/ {

    var movies: [Movie] = []
    var moviesRealm: [MovieRealmModel] = []
    let cachingController = UserDefaultsController()
//    var genres: [GenreNew] = []
    
    let networkController = NetworkController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.prefetchDataSource = self
        loadData()
    }
    
    private func loadData() {
        Task.init {
            
            let cachedMovies = cachingController.load()
            
            if cachedMovies.count > 0 {
                self.movies = cachedMovies
                self.tableView.reloadData()
                return
            }
            
            do {
                self.movies += try await networkController.loadPage(page: 1)
                cachingController.save(movies: movies)
//                self.genres += try await networkController.loadGenresData()
                self.tableView.reloadData()
            } catch {
                print(error)
            }
        }
    }

    private func movieToRealm() {
        
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)

        guard indexPath.item < movies.count else { return cell }
        
        let movie = movies[indexPath.item]
//        var genresFromIDs = ""
//
//        for genreID in movie.genreIDS {
//            if let genre = genres.first(where: { $0.id == genreID }) {
//                genresFromIDs += "\(genre.name), "
//            }
//        }
//        if !genresFromIDs.isEmpty {
//            genresFromIDs.removeLast(2)
//        }
        
        var config = cell.defaultContentConfiguration()
        config.text = movie.title
//        config.secondaryText = genresFromIDs
        
        cell.contentConfiguration = config
        
        if indexPath.row == movies.count - 1 {
            loadData()
        }

        return cell
    }

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let items = indexPaths.map { $0.item }

        if items.contains(movies.count / 2) {
            loadData()
        }
    }

}
