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
struct APIMovieFull: Unboxable {
    let id: Int
    let score: Float?
    let title: String
    let overview: String
    let releaseDate: Date?
    let poster: String?
    let genres: [APIMovieGenre]
    let creators: [APIMovieCreator]
    let actors: [APIMovieActor]
//    let pictures: [APIPictureGallery]
    let videos: [APIMovieVideo]
    let reviews: [APIMovieReviews]
    
    init(unboxer: Unboxer) throws {
        id = try unboxer.unbox(key: "id")
        score = unboxer.unbox(key: "vote_average")
        title = try unboxer.unbox(key: "title")
        overview = try unboxer.unbox(key: "overview")
        poster = unboxer.unbox(key: "poster_path")
        let df = DateFormatter()
        df.dateFormat = "YYYY-MM-dd"
        releaseDate = unboxer.unbox(key: "release_date", formatter: df)
        genres = try unboxer.unbox(key: "genres")
        actors = try unboxer.unbox(keyPath: "credits.cast")
        creators = try unboxer.unbox(keyPath: "credits.crew")
//        pictures = try unboxer.unbox(key: "posters")
        videos = try unboxer.unbox(keyPath: "videos.results")
        reviews = try unboxer.unbox(keyPath: "reviews.results")
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
    
    // Filter actors for the movie with pictures/name/roles
    func filterActors() -> String {
        var mainActorsNames: [String] = []
        var mainActorsCharecters: [String] = []
        for actor in actors {
            mainActorsNames.append(actor.name)
        }
        if mainActorsNames.isEmpty {
            return "There isn't any crew added to this movie."
        } else {
            return mainActorsNames.joined(separator: ", ")
        }
        
        for actor in actors {
            mainActorsCharecters.append(actor.character)
        }
        if mainActorsCharecters.isEmpty {
            return "There isn't any crew added to this movie."
        } else {
            return mainActorsCharecters.joined(separator: ", ")
        }
    }
    
    //    func filterVideos() -> String {
    //        var mainCreators: [String] = []
    //        for creator in creators {
    //            if creator.job == "Director" || creator.job == "Writer" {
    //                mainCreators.append(creator.name)
    //            }
    //        }
    //        if mainCreators.isEmpty {
    //            return "There isn't any crew added to this movie."
    //        } else {
    //            return mainCreators.joined(separator: ", ")
    //        }
    //    }
    
    //    func filterReviews() -> String {
    //        var mainReviews: [Dictionary] = [] as! [Dictionary]
    //        for review in reviews {
    //            if creator.job == "Director" || creator.job == "Writer" {
    //                mainCreators.append(creator.name)
    //            }
    //        }
    //        if mainReviews.isEmpty {
    //            return "There isn't any crew added to this movie."
    //        } else {
    //            return mainReviews.joined(separator: ", ")
    //        }
    //    }
    
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
    
    enum ActorGender: Int, UnboxableEnum {
        case male = 1
        case female = 2
    }
    
    let character: String
    let name: String
    let order: Int
    let id: Int
    let picture: String?
    let gender: ActorGender?
    
    init(unboxer: Unboxer) throws {
        id = try unboxer.unbox(key: "id")
        character = try unboxer.unbox(key: "character")
        name = try unboxer.unbox(key: "name")
        order = try unboxer.unbox(key: "order")
        picture = unboxer.unbox(key: "profile_path")
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

struct APIMovieGenre: Unboxable {
    let id: Int
    let name: String
    
    init(unboxer: Unboxer) throws {
        id = try unboxer.unbox(key: "id")
        name = try unboxer.unbox(key: "name")
    }
}


//////////////////////////////////////////////////////////////////
// Prepares partial movie information for other than detail pages
/////////////////////////////////////////////////////////////////
struct APIMovieStub: Unboxable {
    let id: Int
    let score: Float
    let title: String
    let genreIds: [Int]
    let overview: String
    let releaseDate: String?
    let poster: String?
    
    init(unboxer: Unboxer) throws {
        id = try unboxer.unbox(key: "id")
        score = try unboxer.unbox(key: "vote_average")
        title = try unboxer.unbox(key: "title")
        genreIds = try unboxer.unbox(key: "genre_ids")
        overview = try unboxer.unbox(key: "overview")
        poster = unboxer.unbox(key: "poster_path")
        releaseDate = unboxer.unbox(key: "release_date")
    }
    
    func url(size: Sizes = .original) -> URL? {
        guard let poster = poster else {
            return nil
        }
        return Constants.imageBaseURL.appendingPathComponent(size.rawValue).appendingPathComponent(poster)
    }
}

////////////////////////////////////////////////////////////////////////////////////
// Prepares results for overvie home page with most popular and now playing movies
///////////////////////////////////////////////////////////////////////////////////
struct APIMovieResults: Unboxable {
    let results: [APIMovieStub]
    
    init(unboxer: Unboxer) throws {
        results = try unboxer.unbox(key: "results")
    }
}


//////////////////////////////////////
// Prepares results for movies search
//////////////////////////////////////
struct APIMSearch: Unboxable {
    let results: [APIMovieStub]
    
    init(unboxer: Unboxer) throws {
        results = try unboxer.unbox(key: "results")
    }
}

struct APIMovieSearch: Unboxable {
    let name: String
    let id: Int
    let year: String?
    let poster: String?
    
    init(unboxer: Unboxer) throws {
        name = try unboxer.unbox(key: "original_title")
        id = try unboxer.unbox(key: "id")
        year = unboxer.unbox(key: "release_date")
        poster = unboxer.unbox(key: "poster_path")
    }
    
    func url(size: Sizes = .original) -> URL? {
        guard let poster = poster else {
            return nil
        }
        return Constants.imageBaseURL.appendingPathComponent(size.rawValue).appendingPathComponent(poster)
    }
}
