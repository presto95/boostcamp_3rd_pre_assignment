//
//  DetailInfoCell.swift
//  BoxOffice
//
//  Created by Presto on 04/12/2018.
//  Copyright © 2018 presto. All rights reserved.
//

import UIKit

class DetailInfoCell: UITableViewCell {
    
    private lazy var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()

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
    
    @IBOutlet private weak var dateLabel: UILabel! {
        didSet {
            dateLabel.text = nil
        }
    }
    
    @IBOutlet private weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.text = nil
        }
    }
    
    @IBOutlet private weak var reservationRateLabel: UILabel! {
        didSet {
            reservationRateLabel.text = nil
        }
    }
    
    @IBOutlet private weak var ratingLabel: UILabel! {
        didSet {
            ratingLabel.text = nil
        }
    }
    
    @IBOutlet private weak var ratingStackView: UIStackView! {
        didSet {
            for view in ratingStackView.arrangedSubviews {
                if let imageView = view as? UIImageView {
                    imageView.image = UIImage(named: "ic_star_large")
                }
            }
        }
    }
    
    @IBOutlet private weak var audienceLabel: UILabel! {
        didSet {
            audienceLabel.text = nil
        }
    }
    
    func setProperties(_ object: MovieDetail) {
        guard let thumbURL = URL(string: object.image) else { return }
        DispatchQueue.global(qos: .userInitiated).async {
            if let imageData = try? Data(contentsOf: thumbURL) {
                DispatchQueue.main.async {
                    self.posterImageView.image = UIImage(data: imageData)
                }
            }
        }
        gradeImageView.image = object.grade.toGradeImage
        titleLabel.text = object.title
        dateLabel.text = "\(object.date) 개봉"
        descriptionLabel.text = "\(object.genre) / \(object.duration)분"
        reservationRateLabel.text = "\(object.reservationGrade)위 \(object.reservationRate)%"
        ratingLabel.text = "\(object.userRating)"
        audienceLabel.text = numberFormatter.string(from: NSNumber(value: object.audience))
        setRatingStackView(rating: object.userRating)
    }
    
    private func setRatingStackView(rating value: Double) {
        for (index, view) in ratingStackView.arrangedSubviews.enumerated() {
            if let imageView = view as? UIImageView {
                let unit = Double(index * 2)
                if value >= unit + 2 {
                    imageView.image = UIImage(named: "ic_star_large_full")
                } else if value >= unit + 1 {
                    imageView.image = UIImage(named: "ic_star_large_half")
                }
            }
        }
    }
}
