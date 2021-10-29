//
//  MovieDetailsViewModel.swift
//  MovieApp
//
//  Created by Daniel Wong on 28/3/21.
//

import Foundation
import RxSwift

class MovieDetailsViewModel {
    
    let moviesDetail: PublishSubject<MovieDetails> = PublishSubject()
    
    func getMovieDetails(id: String) {
        guard let url = URL(string: Constants.getMovieDetailPrefix + id + Constants.apiKeyInfix
                                + Constants.apiKey) else {
            return
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, _, error) in
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
                let movieDetails = try decoder.decode(MovieDetails.self, from: data)
                self.moviesDetail.onNext(movieDetails)
            } catch let jsonError as NSError {
                print("JSON decode failed: \(jsonError.localizedDescription)")
            }
        }
        
        dataTask.resume()
    }
    
}
