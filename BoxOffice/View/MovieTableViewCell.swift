//
//  MovieTableViewCell.swift
//  BoxOffice
//
//  Created by Presto on 04/12/2018.
//  Copyright © 2018 presto. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView! {
        didSet {
            posterImageView.image = nil
        }
    }
    
    @IBOutlet weak var gradeImageView: UIImageView! {
        didSet {
            gradeImageView.image = nil
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = nil
        }
    }
    
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.text = nil
        }
    }
    
    @IBOutlet weak var dateLabel: UILabel! {
        didSet {
            dateLabel.text = nil
        }
    }

    func setProperties(_ object: MovieList) {
        titleLabel.text = object.title
        descriptionLabel.text = "평점 : \(object.userRating) 예매순위 : \(object.reservationGrade) 예매율 : \(object.reservationRate)"
        dateLabel.text = "개봉일 : \(object.date)"
    }
}
