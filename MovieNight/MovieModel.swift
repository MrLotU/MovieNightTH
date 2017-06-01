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
    //Get intersected genres
    var intersectedGenres: [Genre] = []
    for genre in person1Genres {
        if person2Genres.contains(genre) {
            intersectedGenres.append(genre)
        }
    }
    
    //Get results
    var results: [Movie] = []
    for genre in intersectedGenres {
        guard let moviesForGenre = moviesByGenre[genre] else {
            //TODO: Get some errors in here
            return []
        }
        results += moviesForGenre
    }
    return results
}
