//
//  MovieRequest.swift
//  BoxOffice
//
//  Created by Presto on 11/01/2019.
//  Copyright © 2019 presto. All rights reserved.
//

import UIKit

protocol MovieRequest: class {
    
    var orderTypeKey: String { get }
    
    var navigationTitles: [String] { get }
    
    var orderType: Int { get set }
    
    var movieLists: [MovieList.Data]? { get set }
    
    func presentSettingActionSheet(to viewController: UIViewController)
    
    func pushDetailViewController(id: String, title: String)
    
    func requestCompletion(movieList: MovieList?, error: Error?)
}

extension MovieRequest {
    var orderTypeKey: String {
        return "orderType"
    }
    
    var navigationTitles: [String] {
        return ["예매율", "큐레이션", "개봉일"]
    }

    func presentSettingActionSheet(to viewController: UIViewController) {
        UIAlertController
            .alert(title: "정렬방식 선택", message: "영화를 어떤 순서로 정렬할까요?", style: .actionSheet)
            .action(title: "예매율") { _ in
                self.orderType = 0
            }
            .action(title: "큐레이션") { _ in
                self.orderType = 1
            }
            .action(title: "개봉일") { _ in
                self.orderType = 2
            }
            .action(title: "취소", style: .cancel, handler: nil)
            .present(to: viewController)
    }
}
