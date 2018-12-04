//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by Presto on 04/12/2018.
//  Copyright © 2018 presto. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    private let cellIdentifiers = ["infoCell", "synopsisCell", "castCell", "commentCell"]
    
    var movieInfo: MovieList.Data?
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
// MARK: - UITableViewDataSource Implementation
extension MovieDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifiers[indexPath.row], for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 3 {
            return 3
        }
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
}
// MARK: - UITableViewDelegate Implementation
extension MovieDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
