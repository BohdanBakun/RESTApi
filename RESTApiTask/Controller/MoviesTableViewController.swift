//
//  MoviesTableViewController.swift
//  RESTApiTask
//
//  Created by Богдан Бакун on 27.05.2023.
//

import UIKit
import Alamofire

class MoviesTableViewController: UITableViewController {

    var movies: [Results] = []
    var genres: [Genre] = []
    
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()

    }
    
    func loadData() {
        Task.init {
            do {
                self.movies = try await networkManager.loadMoviesData()
                self.genres = try await networkManager.loadGenresData()
                tableView.reloadData()
            } catch {
                print(error)
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)
        
        guard indexPath.item < movies.count else { return cell }

        let movie = movies[indexPath.item]
        var genresFromIDs = ""

        for genreID in movie.genreIDS {
            if let genre = genres.first(where: { $0.id == genreID }) {
                genresFromIDs += "\(genre.name), "
            }
        }
        if !genresFromIDs.isEmpty {
            genresFromIDs.removeLast(2)
        }


        var config = cell.defaultContentConfiguration()
        config.text = movie.title
        config.secondaryText = genresFromIDs


        cell.contentConfiguration = config
        
        return cell
    }
}
