//
//  Network.swift
//  BoxOffice
//
//  Created by Presto on 04/12/2018.
//  Copyright © 2018 presto. All rights reserved.
//

import Foundation

class Network {
    static func get(_ url: URL, successHandler: ((Data) -> Void)?, failureHandler: ((Error) -> Void)?) {
        let session = URLSession(configuration: .default)
        IndicatorView.shared.show()
        let task = session.dataTask(with: url) { data, response, error in
            defer {
                IndicatorView.shared.hide()
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
                failureHandler?(NetworkError(rawValue: statusCode) ?? .unknownError)
            }
        }
        task.resume()
    }
}
