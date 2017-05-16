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
public var moviesByGenre: [Genre: [Movie]] = [:]

public enum Genre: Int {
    
    case Action = 28, Adventure = 12, Animation = 16, Comedy = 35, Crime = 80, Documentary = 90, Drama = 18, Family = 10751, Fantasy = 14, History = 36, Horror = 27, Music = 10402, Mystery = 9648, Romance = 10749, ScienceFiction = 878, TVMovie = 10770, Thriller = 53, War = 10752, Western = 37
    
    var id: Int {
        switch self {
        case .Action: return 28
        case .Adventure: return 12
        case .Animation: return 16
        case .Comedy: return 35
        case .Crime: return 80
        case .Documentary: return 90
        case .Drama: return 18
        case .Family: return 10751
        case .Fantasy: return 14
        case .History: return 36
        case .Horror: return 27
        case .Music: return 10402
        case .Mystery: return 9648
        case .Romance: return 10749
        case .ScienceFiction: return 878
        case .TVMovie: return 10770
        case .Thriller: return 53
        case .War: return 10752
        case .Western: return 37
        }
    }
    
    var movies: [Movie] {
        return []
    }
}

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
    var genres: [Genre] = []
    for genreDict in genresRaw {
        guard let id = genreDict["id"].int else {print("Something exploded"); return}
        guard let genre = Genre(rawValue: id) else {print("Something exploded"); return}
        genres.append(genre)
    }
    guard let backdropPath = json["backdrop_path"].string else {print("Something exploded"); return}
    guard let posterPath = json["poster_path"].string else {print("Something exploded"); return}
    
    let movie = Movie(title: title, genres: genres, backdropPath: backdropPath, posterPath: posterPath)
    //FIXME: don't just movies.append, needs to be changed
    movies.append(movie)
}

func getMovies(byGenre genre: Genre) {
    Alamofire.request("https://api.themoviedb.org/3/genre/\(genre.rawValue)/movies?api_key=\(API_Key)&language=en-US&include_adult=true&sort_by=created_at.desc").responseJSON {
        if $0.result.value != nil {
            let json = JSON($0.result.value!)
            createMovie(fromJSON: json, withGenre: genre)
        }
    }
}

func createMovie(fromJSON json: JSON, withGenre genre: Genre) {
    guard let results = json["results"].array else {print("Something exploded! Results ="); return}
    var moviesForGenre: [Movie] = []
    for result in results {
        guard let title = result["title"].string else {print("Something exploded! title ="); return}
        guard let genresRaw = json["genre_ids"].arrayObject else {print("Something exploded! genre_ids ="); return}
        var genres: [Genre] = []
        for genreId in genresRaw {
            let id = genreId as! Int
            guard let genre = Genre(rawValue: id) else {print("Something exploded! genre ="); return}
            genres.append(genre)
        }
        guard let backdropPath = result["backdrop_path"].string else {print("Something exploded! backdrop_path ="); return}
        guard let posterPath =  result["poster_path"].string else {print("Something exploded! poster_path ="); return}
        let movie = Movie(title: title, genres: genres, backdropPath: backdropPath, posterPath: posterPath)
        moviesForGenre.append(movie)
    }
    moviesByGenre.updateValue(moviesForGenre, forKey: genre)
    print(moviesByGenre[genre])
}
















