//
//  BaseTableViewController.swift
//  Upcoming Movies
//
//  Created by Pedro Bandeira on 2/3/19.
//

import UIKit

class BaseTableViewController: UITableViewController {

    var movieRoot: MovieRoot?
    var genres: [Genre]?
    
    var prefetchAction: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "movieCell")
        tableView.prefetchDataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            guard let selectedRow = tableView.indexPathForSelectedRow?.row else { return }
            
            let detailsViewController = segue.destination as? DetailsViewController
            detailsViewController?.selectedMovie = self.movieRoot?.results[selectedRow]
            detailsViewController?.selectedGenres = self.genres
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieRoot?.results.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieTableViewCell
        let movie = movieRoot?.results[indexPath.row]
        
        let mainGenre = genres?.filter({ (genre) -> Bool in
            return genre.id == movie?.genreIds?.first
        }).first
        
        cell.handleView(movie, genre: mainGenre?.name)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showDetails", sender: self)
    }
}

extension BaseTableViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            prefetchAction?()
        }
    }
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        guard let moviesCount = movieRoot?.results.count else {
            return false
        }
        
        return indexPath.row >= moviesCount - 1
    }
}

