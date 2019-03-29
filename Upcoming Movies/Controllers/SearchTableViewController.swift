//
//  SearchTableViewController.swift
//  Upcoming Movies
//
//  Created by Pedro Bandeira on 2/2/19.
//

import UIKit

class SearchTableViewController: BaseTableViewController {
    
    weak var delaySearchTimer: Timer?
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Search"
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "All movies"
        searchController.searchBar.tintColor = .black
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        
        fetchGenres()
        
        prefetchAction = { [weak self] in
            guard let self = self else { return }
            
            if self.searchController.isActive {
                self.fetchMovies(search: self.searchController.searchBar.text ?? "")
            }
        }
    }
    
    func filterContentForSearchText(_ searchText: String) {
        self.delaySearchTimer?.invalidate()
        self.delaySearchTimer = Timer.scheduledTimer(withTimeInterval: searchText.isEmpty ? 0.1 : 0.5, repeats: false, block: { (_) in
            self.fetchMovies(reset: true, search: searchText)
        })
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
    
    private func fetchMovies(reset: Bool = false, search: String = "") {
        let totalPages = movieRoot?.totalPages ?? 0
        let currentPage = movieRoot?.page ?? 0
        let nextPage = reset ? 1 : currentPage + 1
        
        if !reset && nextPage > totalPages {
            return
        }
        
        if search.isEmpty {
            self.movieRoot = nil
            self.tableView.reloadData()
            
            return
        }
        
        APIClient.searchMovies(page: nextPage, query: search) { [weak self] (result) in
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
        }
    }
}

extension SearchTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text ?? "")
    }
}
