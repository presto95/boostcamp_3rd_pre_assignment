//
//  MovieCollectionViewController.swift
//  BoxOffice
//
//  Created by Presto on 04/12/2018.
//  Copyright © 2018 presto. All rights reserved.
//

import UIKit

class MovieCollectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
// MARK: - UICollectionViewDataSource Implementation
extension MovieCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if let movieCell = cell as? MovieCollectionViewCell {
            
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }
}
//MARK: - UICollectionViewDelegate Implementation
extension MovieCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: NSStringFromClass(MovieDetailTableViewController.self)) else { return }
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
