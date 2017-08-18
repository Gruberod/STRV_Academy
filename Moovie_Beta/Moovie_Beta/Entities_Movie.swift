//
//  Entities.swift
//  Moovie_Beta
//
//  Created by Gruberova, Daniela on 18/08/2017.
//  Copyright © 2017 Gruberova, Daniela. All rights reserved.
//

import Foundation
import Unbox


struct Movie: Unboxable {
    let title: String
    let releaseDate: Date
    let genres: [Genre]
    let actors: [MovieActor]
    let videos: [Video]
    let reviews: [Reviews]
    
    
    init(unboxer: Unboxer) throws {
        title = try unboxer.unbox(key: "title")
        genres = try unboxer.unbox(key: "genres")
        // not keyPath property here - you can go deeper into json structure using keypaths
        actors = try unboxer.unbox(keyPath: "credits.cast")
        videos = try unboxer.unbox(keyPath: "videos.results")
        reviews = try unboxer.unbox(keyPath: "reviews.results")
        
        // working with formatters - you need to explicitly specify the formater so that the conversion can take place
        // this is different from UnboxableByTransform
        let df = DateFormatter()
        df.dateFormat = "YYYY-MM-dd"
        releaseDate = try unboxer.unbox(key: "release_date", formatter: df)

    }
}

struct Genre: Unboxable {
    let id: Int
    let name: String
    
    init(unboxer: Unboxer) throws {
        id = try unboxer.unbox(key: "id")
        name = try unboxer.unbox(key: "name")
    }
    
}

struct MovieActor: Unboxable {
    let character: String
    let name: String
    let profileImage: ImageReference?
    let order: Int
    let actorId: Int
    
    init(unboxer: Unboxer) throws {
        character = try unboxer.unbox(key: "character")
        name = try unboxer.unbox(key: "name")
        profileImage = unboxer.unbox(key: "profile_path")
        order = try unboxer.unbox(key: "order")
        actorId = try unboxer.unbox(key: "id")
    }
}

struct Video: Unboxable {
    let key: String
    let name: String
    let site: String
    let type: String
    
    init(unboxer: Unboxer) throws {
        key = try unboxer.unbox(key: "key")
        name = try unboxer.unbox(key: "name")
        site = try unboxer.unbox(key: "site")
        type = try unboxer.unbox(key: "type")
    }
}

struct Reviews: Unboxable {
    let id: String
    let author: String
    let content: String
    
    init(unboxer: Unboxer) throws {
        id = try unboxer.unbox(key: "id")
        author = try unboxer.unbox(key: "author")
        content = try unboxer.unbox(key: "content")
    }
}
