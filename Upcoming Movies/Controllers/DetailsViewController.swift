//
//  DetailsViewController.swift
//  Upcoming Movies
//
//  Created by Pedro Bandeira on 2/3/19.
//

import UIKit
import Nuke

class DetailsViewController: UIViewController {

    @IBOutlet weak var ivBackDrop: UIImageView!
    @IBOutlet weak var ivPoster: UIImageView!
    @IBOutlet weak var lbOverview: UILabel!
    @IBOutlet weak var lbReleaseDate: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbGenres: UILabel!
    
    var selectedMovie: Movie?
    var selectedGenres: [Genre]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Details"
        
        setPosterImage()
        setBackdropImage()
        
        lbTitle.text = selectedMovie?.title
        lbOverview.text = selectedMovie?.overview
        lbReleaseDate.text = selectedMovie?.releaseDate?.formatDate()
        lbGenres.text = getGenresWithID(selectedMovie?.genreIds ?? [])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setBackdropImage() {
        guard let backdropURL = selectedMovie?.backdropURL else { return }
        
        Nuke.loadImage(with: backdropURL, into: ivBackDrop)
    }
    
    private func setPosterImage() {
        guard let posterURL = selectedMovie?.posterURL else { return }
        
        Nuke.loadImage(with: posterURL, into: ivPoster)
    }
    
    private func getGenresWithID(_ ids: [Int]) -> String? {
        var genres: [String] = []
        
        ids.forEach { (id) in
            genres += selectedGenres?.filter{ $0.id == id }.compactMap{ $0.name ?? "" } ?? []
        }
        
        return genres.joined(separator: ", ")
    }
}
