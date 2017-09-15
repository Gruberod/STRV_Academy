//
//  Entities_Actor.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 18/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import Foundation
import Unbox

/////////////////////////////////////////////////
// Prepares full actor info for movie detail page
/////////////////////////////////////////////////
struct APIActor: Unboxable {
    let name: String
    let id: Int
    let picture: String?
    let bio: String?
    let birthday: Date?
    let placeOfBirth: String?
    let knownFor: [APIActorKnownFor]?
    let popularKnownFor: [APIActorKnownFor]?
    let acting: [APIActorActing]?


    init(unboxer: Unboxer) throws {
        let df = DateFormatter()
        df.dateFormat = "YYYY-MM-dd"
        
        name = try unboxer.unbox(key: "name")
        id = try unboxer.unbox(key: "id")
        picture = unboxer.unbox(key: "profile_path")
        bio = unboxer.unbox(key: "biography")
        birthday = unboxer.unbox(key: "birthday", formatter: df)
        placeOfBirth = unboxer.unbox(key: "place_of_birth")
        knownFor = unboxer.unbox(keyPath: "combined_credits.cast")
        popularKnownFor = unboxer.unbox(key: "known_for")
        acting = unboxer.unbox(keyPath: "combined_credits.cast")
    }
    
    func url(size: Sizes = .original) -> URL? {
        guard let picture = picture else {
            return nil
        }
        return Constants.imageBaseURL.appendingPathComponent(size.rawValue).appendingPathComponent(picture)}
/*
    func makeMovieStub(data: APIActorKnownFor) -> MovieStub {
        return MovieStub(title: data.title, id: data.id, genres: [""], description: "", releaseDate: nil, score: "", poster: data.url(size: .w500))
    }
*/
    func filterMoviesKnownFor() -> String {
        var mainMovies: [String] = []
        guard let popularKnownFor = popularKnownFor else {
            return "No movies found"
        }
        for movie in popularKnownFor {
            if let title = movie.title {
                mainMovies.append(title)
            }
        }
        
        if mainMovies.isEmpty {
            return "There aren't any movies."
        } else {
            return mainMovies.joined(separator: ", ")
        }
    }
    
}

struct APIActorKnownFor: Unboxable {
    let posterPath: String?
    let title: String?
    let id: Int
    
    init(unboxer: Unboxer) throws {
        posterPath = unboxer.unbox(key: "poster_path")
        title = unboxer.unbox(key: "title")
        id = try unboxer.unbox(key: "id")
    }
    
    func url(size: Sizes = .original) -> URL? {
        guard let posterPath = posterPath else {
            return nil
        }
        return Constants.imageBaseURL.appendingPathComponent(size.rawValue).appendingPathComponent(posterPath)
    }
    
}


struct APIActorActing: Unboxable {
    let character: String
    let originalName: String
    let airYear: Date

    init(unboxer: Unboxer) throws {
        character = try unboxer.unbox(key: "character")
        originalName = try unboxer.unbox(key: "original_name")
        let df = DateFormatter()
        df.dateFormat = "YYYY"
        airYear = try unboxer.unbox(key: "first_air_date", formatter: df)
    }
}

////////////////////////////////////////////////////////////////////////////
// Prepares collection of most popular movie actors with picture/name/movies
////////////////////////////////////////////////////////////////////////////
struct APIPopular: Unboxable {
    let results: [APIActor]
    
    init(unboxer: Unboxer) throws {
        results = try unboxer.unbox(key: "results")
    }
}


///////////////////////////////
// Prepares actor search items
///////////////////////////////
struct APISearch: Unboxable {
    let results: [APIActor]
    
    init(unboxer: Unboxer) throws {
        results = try unboxer.unbox(key: "results")
    }
}


/*


struct APIActorPopular: Unboxable {
    let name: String
    let id: Int
    let bio: String?
    let birthday: Date?
    let placeOfBirth: String?
    let picture: String?
    var knownFor: [APIPopularKnownFor]
    let acting: [APIActorActing]
    
    init(unboxer: Unboxer) throws {
        name = try unboxer.unbox(key: "name")
        id = try unboxer.unbox(key: "id")
        bio = nil
        birthday
        picture = unboxer.unbox(key: "profile_path")
        knownFor = try unboxer.unbox(key: "known_for")

    }
    
    func url(size: Sizes = .original) -> URL? {
        guard let picture = picture else {
            return nil
        }
        return Constants.imageBaseURL.appendingPathComponent(size.rawValue).appendingPathComponent(picture)
    }
    
    func filterMoviesKnownFor() -> String {
        var mainMovies: [String] = []
            for movie in knownFor {
                if let movieTitle = movie.movieTitle {
                    mainMovies.append(movieTitle)
                }
        }

        if mainMovies.isEmpty {
            return "There aren't any movies."
        } else {
            return mainMovies.joined(separator: ", ")
        }
    }
}


struct APIPopularKnownFor: Unboxable {
    let movieTitle: String?
    
    init(unboxer: Unboxer) throws {
        movieTitle = unboxer.unbox(key: "original_title")
    }
}



struct APIActorSearch: Unboxable {
    let name: String
    let id: Int
    let picture: String?
    
    init(unboxer: Unboxer) throws {
        name = try unboxer.unbox(key: "name")
        id = try unboxer.unbox(key: "id")
        picture = unboxer.unbox(key: "profile_path")
    }
    
    func url(size: Sizes = .original) -> URL? {
        guard let picture = picture else {
            return nil
        }
        return Constants.imageBaseURL.appendingPathComponent(size.rawValue).appendingPathComponent(picture)}
}
 */
