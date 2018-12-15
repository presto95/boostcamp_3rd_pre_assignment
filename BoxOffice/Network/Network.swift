//
//  Network.swift
//  BoxOffice
//
//  Created by Presto on 04/12/2018.
//  Copyright © 2018 presto. All rights reserved.
//

import Foundation
import UIKit

class Network {
    /// HTTP 통신의 GET 메소드 정의.
    ///
    /// - Parameters:
    ///   - url: 웹 URL
    ///   - successHandler: 통신 성공시 실행할 핸들러
    ///   - failureHandler: 통신 실패시 실행할 핸들러
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
    
    /// 네트워크로부터 이미지 받아오기.
    ///
    /// - Parameters:
    ///   - url: 웹 URL
    ///   - completion: 통신 후 실행할 핸들러
    static func fetchImage(from url: URL, completion: ((UIImage?, Error?) -> Void)?) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        DispatchQueue.global(qos: .userInitiated).async {
            defer {
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
            do {
                let imageData = try Data(contentsOf: url)
                DispatchQueue.main.async {
                    let image = UIImage(data: imageData)
                    completion?(image, nil)
                }
            } catch {
                completion?(nil, error)
            }
        }
    }
}
