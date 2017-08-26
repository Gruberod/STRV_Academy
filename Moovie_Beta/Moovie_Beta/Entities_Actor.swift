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
    
    let knownFor: [APIActorKnownFor]
    let acting: [APIActorActing]


    init(unboxer: Unboxer) throws {
        name = try unboxer.unbox(key: "name")
        bio = try unboxer.unbox(key: "bio")
        let df = DateFormatter()
        df.dateFormat = "YYYY-MM-dd"
        birthday = try unboxer.unbox(key: "birthday", formatter: df)
        placeOfBirth = try unboxer.unbox(key: "placeOfBirth")
        knownFor = try unboxer.unbox(keyPath: "combined_credits.cast")
        acting = try unboxer.unbox(keyPath: "combined_credits.cast")
    }
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
