//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by Daniel Wong on 28/3/21.
//

import Foundation
import UIKit
import RxSwift

class MovieDetailsViewController: UIViewController {
    var id: Int?
    
    @IBOutlet var moviePosterImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var synopsisText: UITextView!
    @IBOutlet var languageLabel: UILabel!
    @IBOutlet var durationLabel: UILabel!
    
    private let movieDetailsViewModel = MovieDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = movieDetailsViewModel.moviesDetail.observe(on: MainScheduler.instance).subscribe { (event) in
            if let movieDetail = event.element {
                self.setUpView(movieDetail: movieDetail)
            }
        }
        if let id = id {
            movieDetailsViewModel.getMovieDetails(id: String(id))
        }
    }
    
    @IBAction func buyTicketsPressed(_ sender: Any) {
        if let url = URL(string: Constants.buyTicketsURL) {
            UIApplication.shared.open(url)
        }
    }
    
    private func setUpView(movieDetail: MovieDetails) {
        if let url = movieDetail.url {
            self.moviePosterImage.load(url: url)
        }
        self.titleLabel.text = movieDetail.original_title
        self.ratingLabel.text = movieDetail.rating
        self.synopsisText.text = movieDetail.overview
        self.languageLabel.text = movieDetail.original_language
        self.durationLabel.text = movieDetail.duration
    }
}
