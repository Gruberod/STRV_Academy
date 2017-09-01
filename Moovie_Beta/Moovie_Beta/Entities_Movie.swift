//
//  Entities.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 18/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import Foundation
import Unbox

struct APIMovieGenre: Unboxable {
    let id: Int
    let name: String
    
    init(unboxer: Unboxer) throws {
        id = try unboxer.unbox(key: "id")
        name = try unboxer.unbox(key: "name")
    }
}

struct APIMovieStub: Unboxable {
    let id: Int
    let score: Float
    let title: String
    let genreIds: [Int]
    let overview: String
    let releaseDate: Date
    let poster: String
    
    init(unboxer: Unboxer) throws {
        id = try unboxer.unbox(key: "id")
        score = try unboxer.unbox(key: "vote_average")
        title = try unboxer.unbox(key: "title")
        genreIds = try unboxer.unbox(key: "genre_ids")
        overview = try unboxer.unbox(key: "overview")
        poster = try unboxer.unbox(key: "poster_path")
        
        let df = DateFormatter()
        df.dateFormat = "YYYY-MM-dd"
        releaseDate = try unboxer.unbox(key: "release_date", formatter: df)
    }
    
    func url(size: Sizes = .original) -> URL {
        return Constants.imageBaseURL.appendingPathComponent(size.rawValue).appendingPathComponent(poster)}
}

struct APIMovieResults: Unboxable {
    let results: [APIMovieStub]
    
    init(unboxer: Unboxer) throws {
        results = try unboxer.unbox(key: "results")
    }
}

struct APIMovieVideo: Unboxable {
    
    enum VideoType: String, UnboxableEnum {
        case trailer = "Trailer"
        case teaser = "Teaser"
        case clip = "Clip"
        case featurette = "Featurette"
    }
    
    let key: String
    let name: String
    let site: String
    let type: VideoType
    
    init(unboxer: Unboxer) throws {
        key = try unboxer.unbox(key: "key")
        name = try unboxer.unbox(key: "name")
        site = try unboxer.unbox(key: "site")
        type = try unboxer.unbox(key: "type")
    }
}

struct APIMovieActor: Unboxable {
    
    enum ActorGender: Int, UnboxableEnum {
        case male = 1
        case female = 2
    }
    
    let character: String
    let name: String
    let order: Int
    let id: Int
    let gender: ActorGender?
    
    init(unboxer: Unboxer) throws {
        id = try unboxer.unbox(key: "id")
        character = try unboxer.unbox(key: "character")
        name = try unboxer.unbox(key: "name")
        order = try unboxer.unbox(key: "order")
        gender = unboxer.unbox(key: "gender")
    }
}

struct APIMovieReviews: Unboxable {
    let id: String
    let author: String
    let content: String

    init(unboxer: Unboxer) throws {
        id = try unboxer.unbox(key: "id")
        author = try unboxer.unbox(key: "author")
        content = try unboxer.unbox(key: "content")
    }
}

struct APIMovieFull: Unboxable {
    let id: Int
    let score: Float?
    let title: String
    let overview: String
    let releaseDate: Date?
    
    let budget: Int?
    let homepage: URL?
    let poster: String?
    let genres: [APIMovieGenre]
    let actors: [APIMovieActor]
    let videos: [APIMovieVideo]?
    let reviews: [APIMovieReviews]?
    
    init(unboxer: Unboxer) throws {
        id = try unboxer.unbox(key: "id")
        score = unboxer.unbox(key: "vote_average")
        title = try unboxer.unbox(key: "title")
        overview = try unboxer.unbox(key: "overview")
        poster = unboxer.unbox(key: "poster_path")
        let df = DateFormatter()
        df.dateFormat = "YYYY-MM-dd"
        releaseDate = unboxer.unbox(key: "release_date", formatter: df)
        budget = unboxer.unbox(key: "budget")
        homepage = unboxer.unbox(key: "homepage")
        genres = try unboxer.unbox(key: "genres")
        actors = try unboxer.unbox(keyPath: "credits.cast")
        videos = unboxer.unbox(keyPath: "videos.results")
        reviews = unboxer.unbox(keyPath: "reviews.results")
    }
    
    func url(size: Sizes = .original) -> URL {
        return Constants.imageBaseURL.appendingPathComponent(size.rawValue).appendingPathComponent(poster!)}
}

struct APIMSearch: Unboxable {
    let results: [APIMovieSearch]
    
    init(unboxer: Unboxer) throws {
        results = try unboxer.unbox(key: "results")
    }
}

struct APIMovieSearch: Unboxable {
    let name: String
    let poster: String
    
    init(unboxer: Unboxer) throws {
        name = try unboxer.unbox(key: "name")
        poster = try unboxer.unbox(key: "poster_path")
    }
    
    func url(size: Sizes = .original) -> URL {
        return Constants.imageBaseURL.appendingPathComponent(size.rawValue).appendingPathComponent(poster)}
}

//struct Movie: Unboxable {
//    let title: String
//    let releaseDate: Date
//    let genres: [Genre]
//    let actors: [MovieActor]
//    let videos: [Video]
//    let reviews: [Reviews]
//    
//    
//    init(unboxer: Unboxer) throws {
//        title = try unboxer.unbox(key: "title")
//        genres = try unboxer.unbox(key: "genres")
//        // not keyPath property here - you can go deeper into json structure using keypaths
//        actors = try unboxer.unbox(keyPath: "credits.cast")
//        videos = try unboxer.unbox(keyPath: "videos.results")
//        reviews = try unboxer.unbox(keyPath: "reviews.results")
//        
//        // working with formatters - you need to explicitly specify the formater so that the conversion can take place
//        // this is different from UnboxableByTransform
//        let df = DateFormatter()
//        df.dateFormat = "YYYY-MM-dd"
//        releaseDate = try unboxer.unbox(key: "release_date", formatter: df)
//
//    }
//}
//
//struct Genre: Unboxable {
//    let id: Int
//    let name: String
//    
//    init(unboxer: Unboxer) throws {
//        id = try unboxer.unbox(key: "id")
//        name = try unboxer.unbox(key: "name")
//    }
//    
//}
//
//struct MovieActor: Unboxable {
//    let character: String
//    let name: String
//    let profileImage: ImageReference?
//    let order: Int
//    let actorId: Int
//    
//    init(unboxer: Unboxer) throws {
//        character = try unboxer.unbox(key: "character")
//        name = try unboxer.unbox(key: "name")
//        profileImage = unboxer.unbox(key: "profile_path")
//        order = try unboxer.unbox(key: "order")
//        actorId = try unboxer.unbox(key: "id")
//    }
//}
//
//struct Video: Unboxable {
//    let key: String
//    let name: String
//    let site: String
//    let type: String
//    
//    init(unboxer: Unboxer) throws {
//        key = try unboxer.unbox(key: "key")
//        name = try unboxer.unbox(key: "name")
//        site = try unboxer.unbox(key: "site")
//        type = try unboxer.unbox(key: "type")
//    }
//}
//
//struct Reviews: Unboxable {
//    let id: String
//    let author: String
//    let content: String
//    
//    init(unboxer: Unboxer) throws {
//        id = try unboxer.unbox(key: "id")
//        author = try unboxer.unbox(key: "author")
//        content = try unboxer.unbox(key: "content")
//    }
//}
