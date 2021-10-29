//
//  MovieAppTests.swift
//  MovieAppTests
//
//  Created by Daniel Wong on 26/3/21.
//

import XCTest
@testable import MovieApp

class MovieAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMovieModel_workingValue_success() {
        let movie = Movie(id: 100, original_title: "Batman", vote_average: 4.4, poster_path: "")
        
        XCTAssertEqual(movie.rating, "4.4⭐")
    }
    
    func testMovieModel_minValue_success() {
        let movie = Movie(id: 100, original_title: "Batman", vote_average: 0, poster_path: "")
        
        XCTAssertEqual(movie.rating, "0⭐")
    }
    
    func testMovieModel_maxValue_success() {
        let movie = Movie(id: 100, original_title: "Batman", vote_average: 10, poster_path: "")
        
        XCTAssertEqual(movie.rating, "10⭐")
    }
    
    func testMovieModel_negativeValue_success() {
        let movie = Movie(id: 100, original_title: "Batman", vote_average: -5.0, poster_path: "")
        
        XCTAssertEqual(movie.rating, "-5.0⭐")
    }
    
    func testMovieModel_infValue_success() {
        let movie = Movie(id: 100, original_title: "Batman", vote_average: Double.greatestFiniteMagnitude, poster_path: "")
        
        XCTAssertEqual(movie.rating, String(Double.greatestFiniteMagnitude) + "⭐")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
