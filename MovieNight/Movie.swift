//
//  Movie.swift
//  MovieNight
//
//  Created by Jari Koopman on 09/05/2017.
//  Copyright © 2017 JarICT. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage

public var movies: [Movie] = []
public var moviesByGenre: [Genre: [Movie]] = [:]

open class Movie {
    let title: String
    let genres: [Genre]
    let backdropPath: String
    let posterPath: String
    let id: Int
    
    func getImage(completion: @escaping ((Image) -> Void)) {
        if posterPath != "" {
            Alamofire.request("https://image.tmdb.org/t/p/original\(posterPath)").responseImage {
                if let image = $0.result.value {
                    completion(image)
                }
            }
        } else if backdropPath != "" {
            Alamofire.request("https://image.tmdb.org/t/p/original\(backdropPath)").responseImage {
                if let image = $0.result.value {
                    completion(image)
                }
            }
        } else {
            completion(UIImage(named: "backdrop")!)
        }
    }
    
    init(id: Int, title: String, genres: [Genre], backdropPath: String, posterPath: String) {
        self.title = title
        self.genres = genres
        self.backdropPath = backdropPath
        self.posterPath = posterPath
        self.id = id
    }
}
