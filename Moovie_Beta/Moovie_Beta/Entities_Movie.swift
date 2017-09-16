//
//  Entities.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 18/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import Foundation
import Unbox
import AlamofireImage

/////////////////////////////////////////////////////////
// Prepares full movie information for movie detail page
////////////////////////////////////////////////////////
struct APIMovie: Unboxable {
    let id: Int
    let title: String
    let poster: String?
    let score: Float?
    let overview: String?
    let releaseDate: Date?
    let genres: [APIMovieGenre]?
    let creators: [APIMovieCreator]?
    let actors: [APIMovieActor]?
    let videos: [APIMovieVideo]?
    let images: [APIImages]?
    let reviews: [APIMovieReviews]?
    
    init(unboxer: Unboxer) throws {
        let df = DateFormatter()
        df.dateFormat = "YYYY-MM-dd"
        
        id = try unboxer.unbox(key: "id")
        title = try unboxer.unbox(key: "title")
        poster = unboxer.unbox(key: "poster_path")
        score = unboxer.unbox(key: "vote_average")
        overview = unboxer.unbox(key: "overview")
        releaseDate = unboxer.unbox(key: "release_date", formatter: df)
        genres = unboxer.unbox(key: "genres")
        actors = unboxer.unbox(keyPath: "credits.cast")
        creators = unboxer.unbox(keyPath: "credits.crew")
        videos = unboxer.unbox(keyPath: "videos.results")
        images = unboxer.unbox(keyPath: "images.backdrops")
        reviews = unboxer.unbox(keyPath: "reviews.results")
        
    }
    
    // transforms poster link to url
    func url(size: Sizes = .original) -> URL? {
        guard let poster = poster else {
            return nil
        }
        return Constants.imageBaseURL.appendingPathComponent(size.rawValue).appendingPathComponent(poster)
    }
    
    // Filter creators and return string of Director and Writers
    func filterCreators() -> String {
        var mainCreators: [String] = []
        guard let creators = creators else {
            return "No crew found"
        }
        for creator in creators {
            if creator.job == "Director" || creator.job == "Writer" {
                mainCreators.append(creator.name)
            }
        }
        if mainCreators.isEmpty {
            return "There isn't any crew added to this movie."
        } else {
            return mainCreators.joined(separator: ", ")
        }
    }
    
}

struct APIImages: Unboxable {
    let picture: String?
    
    init(unboxer: Unboxer) throws {
        picture = unboxer.unbox(key: "file_path")
    }
    func url(size: Sizes = .original) -> URL? {
        guard let picture = picture else {
            return nil
        }
        return Constants.imageBaseURL.appendingPathComponent(size.rawValue).appendingPathComponent(picture)
    }
}

struct APIMovieVideo: Unboxable {
    let key: String?
    let name: String?

    init(unboxer: Unboxer) throws {
        key = unboxer.unbox(key: "key")
        name = unboxer.unbox(key: "name")

    }
}

struct APIMovieCreator: Unboxable {
    
    let job: String
    let name: String
    
    init(unboxer: Unboxer) throws {
        job = try unboxer.unbox(key: "job")
        name = try unboxer.unbox(key: "name")
    }
}

struct APIPictureGallery: Unboxable {
    
    let picture: String?
    
    init(unboxer: Unboxer) throws {
        picture = unboxer.unbox(key: "file_path")
    }
}

struct APIMovieActor: Unboxable {
    
    let character: String
    let name: String
    let id: Int
    let picture: String?
    
    init(unboxer: Unboxer) throws {
        id = try unboxer.unbox(key: "id")
        character = try unboxer.unbox(key: "character")
        name = try unboxer.unbox(key: "name")
        picture = unboxer.unbox(key: "profile_path")
    }
    
    func url(size: Sizes = .original) -> URL? {
        guard let picture = picture else {
            return nil
        }
        return Constants.imageBaseURL.appendingPathComponent(size.rawValue).appendingPathComponent(picture)
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

struct APIMovieGenre: Unboxable {
    let id: Int
    let name: String
    
    init(unboxer: Unboxer) throws {
        id = try unboxer.unbox(key: "id")
        name = try unboxer.unbox(key: "name")
    }
}

////////////////////////////////////////////////////////////////////////////////////
// Prepares results for overvie home page with most popular and now playing movies
///////////////////////////////////////////////////////////////////////////////////
struct APIMovieResults: Unboxable {
    let results: [APIMovie]
    
    init(unboxer: Unboxer) throws {
        results = try unboxer.unbox(key: "results")
    }
}


//////////////////////////////////////
// Prepares results for movies search
//////////////////////////////////////
struct APIMSearch: Unboxable {
    let results: [APIMovie]
    
    init(unboxer: Unboxer) throws {
        results = try unboxer.unbox(key: "results")
    }
}
