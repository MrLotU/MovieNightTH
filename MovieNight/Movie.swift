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

enum ImageType {
    case backDrop, poster
}

class Movie {
    let title: String
    let genres: [[String]]
    let backdropPath: String
    let posterImage: String
    
    func getImage(completion: @escaping ((Image) -> Void)) {
        if backdropPath != "" {
            Alamofire.request("https://image.tmdb.org/t/p/w500/kqjL17yufvn9OVLyXYpvtyrFfak.jpg").responseImage {
                if let image = $0.result.value {
                    completion(image)
                }
            }
        } else if posterImage != "" {
            Alamofire.request("").responseImage {
                if let image = $0.result.value {
                    completion(image)
                }
            }
        } else {
            print("No image found, aww")
        }
    }
    
    init(title: String, genres: [[String]], backdropPath: String, posterPath: String) {
        self.title = title
        self.genres = genres
        self.backdropPath = backdropPath
        self.posterImage = posterPath
    }
}
