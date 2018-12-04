//
//  MovieBaseViewController.swift
//  BoxOffice
//
//  Created by Presto on 04/12/2018.
//  Copyright © 2018 presto. All rights reserved.
//

import UIKit

class MovieBaseViewController: UIViewController {
    
    let orderTypeKey = "orderType"
    
    var orderType: Int {
        get {
            return UserDefaults.standard.integer(forKey: orderTypeKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: orderTypeKey)
            navigationItem.title = {
                switch newValue {
                case 0:
                    return "예매율"
                case 1:
                    return "큐레이션"
                case 2:
                    return "개봉일"
                default:
                    return nil
                }
            }()
            API.requestMovieList(orderType: newValue, completion: self.requestCompletion)
        }
    }
    
    var movieLists: [MovieList.Data]?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        orderType = UserDefaults.standard.integer(forKey: orderTypeKey)
    }
    
    func requestCompletion(movieList: MovieList?, error: Error?) {
        if let error = error {
            UIAlertController.presentErrorAlert(to: self, message: error.localizedDescription)
            return
        }
        guard let movieList = movieList else { return }
        self.movieLists = movieList.movies
    }
    
    func presentSettingActionSheet() {
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
            .present(to: self)
    }
}
