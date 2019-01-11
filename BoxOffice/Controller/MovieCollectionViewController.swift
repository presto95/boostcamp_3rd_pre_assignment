//
//  MovieCollectionViewController.swift
//  BoxOffice
//
//  Created by Presto on 04/12/2018.
//  Copyright © 2018 presto. All rights reserved.
//

import UIKit

class MovieCollectionViewController: UIViewController {

    lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(refreshControlShouldOccur(_:)), for: .valueChanged)
        return control
    }()
    
    private var _movieLists: [MovieList.Data]?
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.refreshControl = refreshControl
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        orderType = UserDefaults.standard.integer(forKey: orderTypeKey)
    }

    @objc private func refreshControlShouldOccur(_ sender: UIRefreshControl) {
        API.requestMovieList(orderType: orderType, completion: requestCompletion(movieList:error:))
    }
    
    @IBAction func touchUpSettingButton(_ sender: UIBarButtonItem) {
        presentSettingActionSheet(to: self)
    }
}

extension MovieCollectionViewController: MovieRequest {
    var orderType: Int {
        get {
            return UserDefaults.standard.integer(forKey: orderTypeKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: orderTypeKey)
            navigationItem.title = navigationTitles[newValue]
            API.requestMovieList(orderType: newValue, completion: self.requestCompletion)
        }
    }
    
    var movieLists: [MovieList.Data]? {
        get {
            return _movieLists
        }
        set {
            _movieLists = newValue
            DispatchQueue.main.async {
                self.collectionView.refreshControl?.endRefreshing()
                self.collectionView.reloadData()
            }
        }
    }
    
    func requestCompletion(movieList: MovieList?, error: Error?) {
        if let error = error {
            UIAlertController
                .alert(title: "오류", message: error.localizedDescription)
                .action(title: "확인")
                .present(to: self)
            return
        }
        guard let movieList = movieList else { return }
        movieLists = movieList.movies
    }
    
    func pushDetailViewController(id: String, title: String) {
        guard let detailViewController = storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else { return }
        detailViewController.title = title
        detailViewController.id = id
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension MovieCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if let movieCell = cell as? MovieCollectionViewCell, let movieList = movieLists?[indexPath.row] {
            movieCell.setProperties(movieList) { image, error in
                if let error = error {
                    UIAlertController
                        .alert(title: "오류", message: error.localizedDescription)
                        .action(title: "확인")
                        .present(to: self)
                    return
                }
                if let currentIndexPath = collectionView.indexPath(for: movieCell), currentIndexPath.item == indexPath.item {
                    movieCell.setPosterImage(image)
                }
            }
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
