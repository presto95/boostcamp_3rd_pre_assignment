//
//  MovieTableViewController.swift
//  BoxOffice
//
//  Created by Presto on 04/12/2018.
//  Copyright © 2018 presto. All rights reserved.
//

import UIKit

class MovieTableViewController: MovieBaseViewController {
    
    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(refreshControlShouldOccur(_:)), for: .valueChanged)
        return control
    }()
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.refreshControl = refreshControl
        }
    }
    
    override func requestCompletion(movieList: MovieList?, error: Error?) {
        super.requestCompletion(movieList: movieList, error: error)
        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
    }
    
    @objc private func refreshControlShouldOccur(_ sender: UIRefreshControl) {
        API.requestMovieList(orderType: orderType, completion: requestCompletion)
    }
    
    @IBAction private func touchUpSettingButton(_ sender: UIBarButtonItem) {
       presentSettingActionSheet()
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
