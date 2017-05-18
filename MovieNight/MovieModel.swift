//
//  MovieModel.swift
//  MovieNight
//
//  Created by Jari Koopman on 18/05/2017.
//  Copyright © 2017 JarICT. All rights reserved.
//

import Foundation
import SwiftyJSON

public var person1Genres: [Genre] = [.Action, .Adventure]
public var person2Genres: [Genre] = [.War, .Action]

func getResults() -> [Movie] {
    //Get intersected genres
    var intersectedGenres: [Genre] = []
    for genre in person1Genres {
        if person2Genres.contains(genre) {
            intersectedGenres.append(genre)
        }
    }
    
    //TODO: Fix for if 0 intersections happened
    
    //Get movies for intersected Genres
    var intersectedMovies: [Movie] = []
    for genre in intersectedGenres {
        if let moviesForGenre = moviesByGenre[genre] {
            intersectedMovies += moviesForGenre
        }
    }
    return movies
}
