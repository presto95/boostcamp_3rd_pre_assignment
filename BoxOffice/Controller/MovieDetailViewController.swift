//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by Presto on 04/12/2018.
//  Copyright © 2018 presto. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    var id: String = ""
    
    private let cellIdentifiers = ["infoCell", "synopsisCell", "castCell", "commentCell"]
    
    private var movieDetail: MovieDetail?
    
    private var comments: [Comment.Data]?
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        API.requestMovieDetail(id: id, completion: requestMovieDetailCompletion)
    }
    
    private func requestMovieDetailCompletion(movieDetail: MovieDetail?, error: Error?) {
        if let error = error {
            UIAlertController.presentErrorAlert(to: self, message: error.localizedDescription)
            return
        }
        guard let movieDetail = movieDetail else { return }
        self.movieDetail = movieDetail
        API.requestComments(id: id, completion: requestCommentCompletion)
    }
    
    private func requestCommentCompletion(data: Comment?, error: Error?) {
        if let error = error {
            UIAlertController.presentErrorAlert(to: self, message: error.localizedDescription)
            return
        }
        guard let comments = data?.comments else { return }
        self.comments = comments
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
// MARK: - UITableViewDataSource Implementation
extension MovieDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifiers[indexPath.section], for: indexPath)
        switch indexPath.section {
        case 0:
            if let infoCell = cell as? DetailInfoCell, let movieDetail = movieDetail {
                infoCell.setProperties(movieDetail)
            }
        case 1:
            if let synopsisCell = cell as? DetailSynopsisCell, let synopsis = movieDetail?.synopsis {
                synopsisCell.setProperties(synopsis)
            }
        case 2:
            if let castCell = cell as? DetailCastCell, let director = movieDetail?.director, let actor = movieDetail?.actor {
                castCell.setProperties(director: director, actor: actor)
            }
        case 3:
            if let commentCell = cell as? DetailCommentCell, let comment = comments?[indexPath.row] {
                commentCell.setProperties(comment, at: indexPath.row)
            }
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard movieDetail != nil, comments != nil else { return 0 }
        if section == 3 {
            return comments?.count ?? 0
        }
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard movieDetail != nil, comments != nil else { return 0 }
        return 4
    }
}
// MARK: - UITableViewDelegate Implementation
extension MovieDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 16))
        footerView.backgroundColor = .lightGray
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 3 { return .leastNonzeroMagnitude }
        return 16
    }
}
