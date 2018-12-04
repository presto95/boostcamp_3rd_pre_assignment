//
//  MovieCollectionViewController.swift
//  BoxOffice
//
//  Created by Presto on 04/12/2018.
//  Copyright © 2018 presto. All rights reserved.
//

import UIKit

class MovieCollectionViewController: MovieBaseViewController {

    lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(refreshControlShouldOccur(_:)), for: .valueChanged)
        return control
    }()
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.refreshControl = refreshControl
        }
    }

    override func requestCompletion(movieList: MovieList?, error: Error?) {
        super.requestCompletion(movieList: movieList, error: error)
        DispatchQueue.main.async {
            self.collectionView.refreshControl?.endRefreshing()
            self.collectionView.reloadData()
        }
    }
    
    @objc private func refreshControlShouldOccur(_ sender: UIRefreshControl) {
        API.requestMovieList(orderType: orderType, completion: requestCompletion)
    }
    
    @IBAction func touchUpSettingButton(_ sender: UIBarButtonItem) {
        presentSettingActionSheet()
    }
}

extension MovieCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if let movieCell = cell as? MovieCollectionViewCell, let movieList = movieLists?[indexPath.row] {
            movieCell.setProperties(movieList)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieLists?.count ?? 0
    }
}

extension MovieCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if let movieList = movieLists?[indexPath.row] {
            pushDetailViewController(id: movieList.id, title: movieList.title)
        }
    }
}

extension MovieCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.bounds.width / 2 - 8
        return CGSize(width: width, height: width * 1.8)
    }
}
