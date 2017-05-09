//
//  DataModel.swift
//  MovieNight
//
//  Created by Jari Koopman on 09/05/2017.
//  Copyright © 2017 JarICT. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

private let API_Key = "7b040a4d1f494a7e961e0262903264da"
public var movies: [Movie] = []

func getMovie(byId id: Int) {
    Alamofire.request("https://api.themoviedb.org/3/movie/\(id)?api_key=\(API_Key)&language=en-US").responseJSON {
        if $0.result.value != nil {
            let json = JSON($0.result.value!)
            createMovie(fromJSON: json)
        }
    }
}

func createMovie(fromJSON json: JSON) {
    guard let title = json["title"].string else {print("Something exploded"); return}
    guard let genresRaw = json["genres"].array else {print("Something exploded"); return}
    var genres: [[String:Int]] = []
    for genre in genresRaw {
        guard let id = genre["id"].int else {print("Something exploded"); return}
        guard let name = genre["name"].string else {print("Something exploded"); return}
        genres.append([name:id])
    }
    guard let backdropPath = json["backdrop_path"].string else {print("Something exploded"); return}
    guard let posterPath = json["poster_path"].string else {print("Something exploded"); return}
    
    print(genres)
    
    
    let movie = Movie(title: title, genres: genres, backdropPath: backdropPath, posterPath: posterPath)
    movies.append(movie)
}
