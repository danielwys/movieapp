//
//  MovieCell.swift
//  MovieApp
//
//  Created by Daniel Wong on 27/3/21.
//

import Foundation
import UIKit

class MovieCell: UICollectionViewCell {
    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var movieRating: UILabel!
    
    var id = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        movieTitle.numberOfLines = 2
    }
    
    override func prepareForReuse() {
        movieImageView = nil
    }
    
}
