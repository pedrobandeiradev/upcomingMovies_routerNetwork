//
//  MovieTableViewCell.swift
//  Upcoming Movies
//
//  Created by Pedro Bandeira on 2/2/19.
//

import UIKit
import Nuke

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var ivPoster: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbGenre: UILabel!
    @IBOutlet weak var lbReleaseDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func handleView(_ movie: Movie?, genre: String?) {
        if let posterURL = movie?.posterURL {
            Nuke.loadImage(with: posterURL, into: ivPoster)
        }
            
        lbTitle.text = movie?.title
        lbGenre.text = genre
        lbReleaseDate.text = movie?.releaseDate?.formatDate()
        
        lbReleaseDate.adjustFontWidth()
    }
}
