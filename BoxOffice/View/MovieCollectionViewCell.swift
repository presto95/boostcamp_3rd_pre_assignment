//
//  MovieCollectionViewCell.swift
//  BoxOffice
//
//  Created by Presto on 04/12/2018.
//  Copyright © 2018 presto. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var posterImageView: UIImageView!
    
    @IBOutlet private weak var gradeImageView: UIImageView! {
        didSet {
            gradeImageView.image = nil
        }
    }
    
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = nil
        }
    }
    
    @IBOutlet private weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.text = nil
        }
    }
    
    @IBOutlet private weak var dateLabel: UILabel! {
        didSet {
            dateLabel.text = nil
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = UIImage(named: "img_placeholder")
        gradeImageView.image = nil
        titleLabel.text = nil
        descriptionLabel.text = nil
        dateLabel.text = nil
    }
    
    func setProperties(_ object: MovieList.Data, imageFetchCompletion completion: @escaping (UIImage?, Error?) -> Void) {
        guard let thumbURL = URL(string: object.thumb) else { return }
        Network.fetchImage(from: thumbURL) { image, error in
            completion(image, error)
        }
        gradeImageView.image = object.grade.toGradeImage
        titleLabel.text = object.title
        descriptionLabel.text = "\(object.reservationGrade)위(\(object.userRating) / \(object.reservationRate)%)"
        dateLabel.text = object.date
    }
    
    func setPosterImage(_ image: UIImage?) {
        posterImageView.image = image
    }
}
