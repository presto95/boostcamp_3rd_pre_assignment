//
//  Comment.swift
//  BoxOffice
//
//  Created by Presto on 04/12/2018.
//  Copyright © 2018 presto. All rights reserved.
//

struct Comment: Codable {
    struct Data: Codable {
        let rating: Double
        let timestamp: Double
        let writer: String
        let movieId: String
        let contents: String
        let id: String
    }
    let comments: [Data]
}
