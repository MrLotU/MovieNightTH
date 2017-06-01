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

//MARK: Extensions

extension ViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

//MARK: Protocols

protocol MovieNightDelegate {
    func setImage(_ image: UIImage, forPerson1 person1: Bool)
    func startOver()
    var personOneDone: Bool { get set }
    var personTwoDone: Bool { get set }
}

//MARK: API

private let API_Key = "7b040a4d1f494a7e961e0262903264da"
public var genres: [Genre] = [.Action, .Adventure, .Animation, .Comedy, .Crime, .Documentary, .Drama, .Family, .Fantasy, .History, .Horror, .Music, .Mystery, .Romance, .ScienceFiction, .TVMovie, .Thriller, .War, .Western]

public enum Genre: Int {
    
    case Action = 28, Adventure = 12, Animation = 16, Comedy = 35, Crime = 80, Documentary = 99, Drama = 18, Family = 10751, Fantasy = 14, History = 36, Horror = 27, Music = 10402, Mystery = 9648, Romance = 10749, ScienceFiction = 878, TVMovie = 10770, Thriller = 53, War = 10752, Western = 37
    
    var name: String {
        switch self {
        case .Action: return "Action"
        case .Adventure: return "Adventure"
        case .Animation: return "Animation"
        case .Comedy: return "Comedy"
        case .Crime: return "Crime"
        case .Documentary: return "Documentary"
        case .Drama: return "Drama"
        case .Family: return "Family"
        case .Fantasy: return "Fantasy"
        case .History: return "History"
        case .Horror: return "Horror"
        case .Music: return "Music"
        case .Mystery: return "Mystery"
        case .Romance: return "Romance"
        case .ScienceFiction: return "Science Fiction"
        case .TVMovie: return "TV Movie"
        case .Thriller: return "Thriller"
        case .War: return "War"
        case .Western: return "Western"
        }
    }
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
    guard let results = json["results"].array else {print("Failed to create results for Genre: \(genre)"); return}
    var moviesForGenre: [Movie] = []
    for result in results {
        guard let id = result["id"].int else {print("Failed to get id for \(result)"); return}
        guard let title = result["title"].string else {print("Failed to create title for id \(id)"); return}
        let backdropPath = result["backdrop_path"].stringValue
        let posterPath = result["poster_path"].stringValue
        guard let genresRaw = result["genre_ids"].arrayObject else {print("Failed to create Genre Ids for title: \(title) and id \(id)"); return}
        var genres: [Genre] = []
        for genreId in genresRaw {
            let id = genreId as! Int
            guard let genre = Genre(rawValue: id) else {print("Failed to create genre withraw value: \(id)"); return}
            genres.append(genre)
        }
        let movie = Movie(id: id, title: title, genres: genres, backdropPath: backdropPath, posterPath: posterPath)
        moviesForGenre.append(movie)
    }
    moviesByGenre.updateValue(moviesForGenre, forKey: genre)
}
