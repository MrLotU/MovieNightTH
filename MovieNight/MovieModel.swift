//
//  MovieModel.swift
//  MovieNight
//
//  Created by Jari Koopman on 18/05/2017.
//  Copyright © 2017 JarICT. All rights reserved.
//

import Foundation
import SwiftyJSON

public var person1Genres: [Genre] = []
public var person2Genres: [Genre] = []


func getResults() -> [Movie] {
    //Get results
    var moviesForPerson1: [Movie] = []
    for genre in person1Genres {
        guard let moviesForGenre = moviesByGenre[genre] else {
            print("Something went wrong. No movies were found for this Genre")
            return []
        }
        moviesForPerson1 += moviesForGenre
    }
    var movieResults: [Movie] = []
    for movie in moviesForPerson1 {
        for genre in movie.genres {
            if person2Genres.contains(genre) {
                movieResults.append(movie)
            }
        }
    }
    
    if !movieResults.isEmpty {
        //Check for no dupes
        let noDupedMovies = uniq(source: movieResults)
        return noDupedMovies
    } else {
        return [Movie(id: 0, title: "No movies found for the genres specified", genres: [], backdropPath: "", posterPath: "")]
    }
}
