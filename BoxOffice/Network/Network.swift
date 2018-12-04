//
//  Network.swift
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

class Network {
    static func get(_ url: URL, successHandler: ((Data) -> Void)?, failureHandler: ((Error) -> Void)?) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            defer {
                session.finishTasksAndInvalidate()
            }
            if let error = error {
                failureHandler?(error)
                return
            }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
            if let data = data, statusCode == 200 {
                successHandler?(data)
            } else {
                failureHandler?(NetworkError(rawValue: statusCode) ?? NetworkError.unknownError)
            }
        }
        task.resume()
    }
}
