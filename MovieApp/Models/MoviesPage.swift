//
//  MoviesPage.swift
//  MovieApp
//
//  Created by Daniel Wong on 28/3/21.
//

import Foundation

struct MoviesPage: Codable {
    let page: Int
    let results: [Movie]
}
