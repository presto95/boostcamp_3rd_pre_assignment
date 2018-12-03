//
//  API.swift
//  BoxOffice
//
//  Created by Presto on 04/12/2018.
//  Copyright © 2018 presto. All rights reserved.
//

import Foundation

class API {
    private static let baseURL = "http://connect-boxoffice.run.goorm.io/"
    private static let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
}

extension API {
    static func requestMovieList(orderType: Int) {
        
    }
}
