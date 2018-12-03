//
//  MovieTableViewController.swift
//  BoxOffice
//
//  Created by Presto on 04/12/2018.
//  Copyright © 2018 presto. All rights reserved.
//

import UIKit

class MovieTableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
// MARK: - UITableViewDataSource Implementation
extension MovieTableViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let movieCell = cell as? MovieTableViewCell {
            // 뷰 구현
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}

// MARK: - UITableViewDelegate Implementation
extension MovieTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: NSStringFromClass(MovieDetailTableViewController.self)) else { return }
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
