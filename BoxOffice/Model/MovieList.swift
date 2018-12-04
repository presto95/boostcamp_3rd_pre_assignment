//
//  MovieList.swift
//  BoxOffice
//
//  Created by Presto on 04/12/2018.
//  Copyright © 2018 presto. All rights reserved.
//

struct MovieList: Codable {
    struct Data: Codable {
        let grade: Int
        let thumb: String
        let reservationGrade: Int
        let title: String
        let reservationRate: Double
        let userRating: Double
        let date: String
        let id: String
    }
    let orderType: Int
    let movies: [Data]
}
