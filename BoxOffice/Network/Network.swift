//
//  Network.swift
//  BoxOffice
//
//  Created by Presto on 04/12/2018.
//  Copyright © 2018 presto. All rights reserved.
//

import Foundation

class Network {
    static func get(_ url: URL, successHandler: ((Data, Int) -> Void)?, failureHandler: ((Error) -> Void)?) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            defer {
                session.finishTasksAndInvalidate()
            }
            if let error = error {
                failureHandler?(error)
                return
            }
            if let statusCode = (response as? HTTPURLResponse)?.statusCode, let data = data, statusCode == 200 {
                successHandler?(data, statusCode)
            } else {
                //failureHandler?(Error())
            }
        }
        task.resume()
    }
}
