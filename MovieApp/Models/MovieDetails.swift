//
//  MovieDetails.swift
//  MovieApp
//
//  Created by Daniel Wong on 28/3/21.
//

import Foundation

struct MovieDetails: Codable {
    let id: Int
    let original_title: String
    let vote_average: Double
    let poster_path: String
    let overview: String
    let original_language: String
    let runtime: Int
    
    var rating: String {
        return String(vote_average) + "⭐"
    }
    var url: URL? {
        return URL(string: Constants.imageUrlPrefix + poster_path)
    }
    
    var duration: String {
        return String(runtime) + "m"
    }
}
