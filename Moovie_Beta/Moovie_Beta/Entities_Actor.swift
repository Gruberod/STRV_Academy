//
//  Entities_Actor.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 18/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import Foundation
import Unbox


struct APIActorFull: Unboxable {
    let name: String
    let bio: String
    let birthday: Date
    let placeOfBirth: String
    let picture: String?
    
    let knownFor: [APIActorKnownFor]?
    let acting: [APIActorActing]?


    init(unboxer: Unboxer) throws {
        name = try unboxer.unbox(key: "name")
        bio = try unboxer.unbox(key: "biography")
        let df = DateFormatter()
        df.dateFormat = "YYYY-MM-dd"
        birthday = try unboxer.unbox(key: "birthday", formatter: df)
        placeOfBirth = try unboxer.unbox(key: "place_of_birth")
        picture = unboxer.unbox(key: "profile_path")
        knownFor = unboxer.unbox(keyPath: "combined_credits.cast")
        acting = unboxer.unbox(keyPath: "combined_credits.cast")
    }
    
    func url(size: Sizes = .original) -> URL? {
        guard let picture = picture else {
            return nil
        }
        return Constants.imageBaseURL.appendingPathComponent(size.rawValue).appendingPathComponent(picture)}
}

struct APIActorKnownFor: Unboxable {
    let posterPath: String
    
    init(unboxer: Unboxer) throws {
        posterPath = try unboxer.unbox(key: "poster_path")
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

struct APIPopular: Unboxable {
    let results: [APIActorPopular]
    
    init(unboxer: Unboxer) throws {
        results = try unboxer.unbox(key: "results")
    }
}

struct APIActorPopular: Unboxable {
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

struct APISearch: Unboxable {
    let results: [APIActorSearch]
    
    init(unboxer: Unboxer) throws {
        results = try unboxer.unbox(key: "results")
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
