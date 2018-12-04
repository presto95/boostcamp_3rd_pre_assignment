//
//  MovieTableViewController.swift
//  BoxOffice
//
//  Created by Presto on 04/12/2018.
//  Copyright © 2018 presto. All rights reserved.
//

import UIKit

class MovieTableViewController: UIViewController {
 
    private let orderTypeKey = "orderType"
    
    private var orderType: Int {
        return UserDefaults.standard.integer(forKey: orderTypeKey)
    }
    
    private var movieLists: [MovieList.Data]?
    
    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(refreshControlShouldOccur(_:)), for: .valueChanged)
        return control
    }()
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            //tableView.rowHeight = UITableView.automaticDimension
            tableView.refreshControl = refreshControl
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        API.requestMovieList(orderType: orderType, completion: requestCompletion)
    }
    
    private func requestCompletion(movieList: MovieList?, error: Error?) {
        if let error = error {
            UIAlertController.presentErrorAlert(to: self, message: error.localizedDescription)
            return
        }
        guard let movieList = movieList else { return }
        self.movieLists = movieList.movies
        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
    }
    
    @objc private func refreshControlShouldOccur(_ sender: UIRefreshControl) {
        API.requestMovieList(orderType: orderType, completion: requestCompletion)
    }
    
    @IBAction private func touchUpSettingButton(_ sender: UIBarButtonItem) {
        UIAlertController
            .alert(title: "정렬방식 선택", message: "영화를 어떤 순서로 정렬할까요?", style: .actionSheet)
            .action(title: "예매율") { _ in
                UserDefaults.standard.set(0, forKey: self.orderTypeKey)
            }
            .action(title: "큐레이션") { _ in
                UserDefaults.standard.set(1, forKey: self.orderTypeKey)
            }
            .action(title: "개봉일") { _ in
                UserDefaults.standard.set(2, forKey: self.orderTypeKey)
            }
            .action(title: "취소", style: .cancel, handler: nil)
            .present(to: self) {
                API.requestMovieList(orderType: self.orderType, completion: self.requestCompletion)
            }
    }
}
// MARK: - UITableViewDataSource Implementation
extension MovieTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let movieCell = cell as? MovieTableViewCell, let movieList = movieLists?[indexPath.row] {
            movieCell.setProperties(movieList)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieLists?.count ?? 0
    }
}

// MARK: - UITableViewDelegate Implementation
extension MovieTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: NSStringFromClass(MovieDetailViewController.self)) else { return }
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
