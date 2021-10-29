//
//  MoviesViewModel.swift
//  MovieApp
//
//  Created by Daniel Wong on 27/3/21.
//

import Foundation
import RxSwift

public class MoviesViewModel {
    
    let movies: PublishSubject<[Movie]> = PublishSubject()
    var currentPage = 1
    
    let disposal = DisposeBag()
    
    public func getMovies() {
        guard let url = URL(string: Constants.discoverMovieUrlPrefix + Constants.apiKey) else {
            return
        }
        
        startDataTask(from: url)
    }
    
    public func getMoviesNextPage() {
        
        guard let url = URL(string: Constants.discoverMovieUrlPrefix + Constants.apiKey +
                                Constants.pageInfix + String(currentPage + 1)) else {
            return
        }
        print(currentPage)
        startDataTask(from: url)
    }
        
    private func startDataTask(from url: URL) {
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url, completionHandler: getMoviesCompletionHandler(data:_:error:))
        dataTask.resume()
    }
    
    private func getMoviesCompletionHandler(data: Data?, _: URLResponse?, error: Error?) {
        guard error == nil else {
            print(error as Any)
            return
        }
        guard let data = data else {
            print("nodata")
            return
        }
        
        let decoder = JSONDecoder()
        do {
            let moviespage = try decoder.decode(MoviesPage.self, from: data)
            self.movies.onNext(moviespage.results)
            self.currentPage = moviespage.page
        } catch let jsonError as NSError {
            print("JSON decode failed: \(jsonError.localizedDescription)")
        }
    }
}
