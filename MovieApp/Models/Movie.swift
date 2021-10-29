//
//  Movie.swift
//  MovieApp
//
//  Created by Daniel Wong on 27/3/21.
//

import Foundation

struct Movie: Codable {
    /// Items required for MovieCell on Home Screen
    let id: Int
    let original_title: String
    let vote_average: Double
    let poster_path: String
    
    var rating: String {
        return String(vote_average) + "⭐"
    }
    var url: URL? {
        return URL(string: Constants.imageUrlPrefix + poster_path)
    }
}
