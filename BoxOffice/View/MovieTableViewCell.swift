//
//  MovieTableViewCell.swift
//  BoxOffice
//
//  Created by Presto on 04/12/2018.
//  Copyright © 2018 presto. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

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
    }
    
    func setProperties(_ object: MovieList.Data, imageFetchCompletion completion: @escaping (UIImage?, Error?) -> Void) {
        guard let thumbURL = URL(string: object.thumb) else { return }
        Network.fetchImage(from: thumbURL, completion: completion)
        gradeImageView.image = object.grade.toGradeImage
        titleLabel.text = object.title
        descriptionLabel.text = "평점 : \(object.userRating) 예매순위 : \(object.reservationGrade) 예매율 : \(object.reservationRate)"
        dateLabel.text = "개봉일 : \(object.date)"
    }
    
    func setPosterImage(_ image: UIImage?) {
        posterImageView.image = image
    }
}
