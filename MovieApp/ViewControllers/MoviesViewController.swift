//
//  MovieViewController.swift
//  MovieApp
//
//  Created by Daniel Wong on 27/3/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class MoviesViewController: UIViewController {
    
    @IBOutlet var movieCollectionView: UICollectionView!
    
    private let itemsPerRow = CGFloat(2)
    private let sectionInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    
    private var movies = PublishSubject<[Movie]>()
    
    private let movieViewModel = MoviesViewModel()
    private let disposeBag = DisposeBag()
    
    private var currentMovieId: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataBinding()
        movieViewModel.getMovies()
    }
    
    private func setupDataBinding() {
        movies.bind(to: movieCollectionView.rx.items(cellIdentifier: "MovieCell",
                                                     cellType: MovieCell.self)) { (_, movie, cell) in
            cell.movieTitle.text = movie.original_title
            cell.movieRating.text = String(movie.rating)
            cell.movieImageView.backgroundColor = UIColor.black
            cell.movieImageView.image = nil
            if let url = movie.url {
                cell.movieImageView.load(url: url)
            }
            cell.id = movie.id
            
        }.disposed(by: disposeBag)
        
        movieCollectionView.rx.setDelegate(self).disposed(by: disposeBag)

        movieViewModel.movies.observe(on: MainScheduler.instance).bind(to: movies).disposed(by: disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "movieDetailsSegue" {
            if let vc = segue.destination as? MovieDetailsViewController {
                vc.id = currentMovieId
            }
        }
    }
    
}

extension MoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell = collectionView.cellForItem(at: IndexPath(row: indexPath.row,
                                                                    section: indexPath.section))
        guard let cell = selectedCell as? MovieCell else {
            return
        }
        
        currentMovieId = cell.id
        performSegue(withIdentifier: "movieDetailsSegue", sender: self)
    }

//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print("scroll")
//        if scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height) {
//            print("hit1")
//            movieViewModel.getMoviesNextPage()
//        }
//    }
}

/// Collection View Flow Layout delegate: enforces cell sizing - 2 items per row
extension MoviesViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let padding = sectionInsets.left * (itemsPerRow + 1)
        let usableWidth = view.frame.width - padding
        let itemWidth = usableWidth / itemsPerRow
        let itemHeight = view.frame.height / 3

        return CGSize(width: itemWidth, height: itemHeight)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
