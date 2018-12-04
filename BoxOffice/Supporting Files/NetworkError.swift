//
//  NetworkError.swift
//  BoxOffice
//
//  Created by Presto on 04/12/2018.
//  Copyright © 2018 presto. All rights reserved.
//

import Foundation

enum NetworkError: Int, Error {
    case badRequestError = 400
    case unauthorizedError = 401
    case forbiddenError = 403
    case notFoundError = 404
    case unknownError
}

extension NetworkError: LocalizedError {
    var localizedDescription: String {
        switch self {
        case .badRequestError:
            return "400 Bad Request"
        case .unauthorizedError:
            return "401 Unauthorized"
        case .forbiddenError:
            return "403 Forbidden"
        case .notFoundError:
            return "404 Not Found"
        case .unknownError:
            return "Unknown Error"
        }
    }
}
