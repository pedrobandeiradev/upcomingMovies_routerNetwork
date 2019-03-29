//
//  MoviesTableViewController.swift
//  Upcoming Movies
//
//  Created by Pedro Bandeira on 2/2/19.
//

import UIKit

class MoviesTableViewController: BaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Upcoming Movies"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        prefetchAction = { [weak self] in
            self?.fetchMovies()
        }
        
        fetchGenres()
    }

    private func fetchGenres() {
        APIClient.getGenres { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let genreRoot):
                self.genres = genreRoot.genres
                self.fetchMovies(reset: true)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchMovies(reset: Bool = false) {
        let totalPages = movieRoot?.totalPages ?? 0
        let currentPage = movieRoot?.page ?? 0
        let nextPage = reset ? 1 : currentPage + 1
        
        if !reset && nextPage > totalPages {
            return
        }
        
        APIClient.getUpcomingMovies(page: nextPage) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let movieRoot):
                if movieRoot.page == 1 {
                    self.movieRoot = movieRoot
                } else {
                    self.movieRoot?.page = movieRoot.page
                    self.movieRoot?.results.append(contentsOf: movieRoot.results)
                }
                
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
            
            self.tableView.refreshControl?.endRefreshing()
        }
    }

    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if tableView.refreshControl?.isRefreshing == true {
            self.fetchGenres()
        }
    }
}
