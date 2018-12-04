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
                switch index {
                case 0 where value >= 0:
                    imageView.image = UIImage(named: "ic_star_large")
                case 1 where value >= 1:
                    imageView.image = UIImage(named: "ic_star_half")
                case 2 where value >= 2:
                    imageView.image = UIImage(named: "ic_star_full")
                case 3 where value >= 3:
                    imageView.image = UIImage(named: "ic_star_half")
                case 4 where value >= 4:
                    imageView.image = UIImage(named: "ic_star_full")
                case 5 where value >= 5:
                    imageView.image = UIImage(named: "ic_star_half")
                case 6 where value >= 6:
                    imageView.image = UIImage(named: "ic_star_full")
                case 7 where value >= 7:
                    imageView.image = UIImage(named: "ic_star_half")
                case 8 where value >= 8:
                    imageView.image = UIImage(named: "ic_star_full")
                case 9 where value >= 9:
                    imageView.image = UIImage(named: "ic_star_half")
                case 10 where value >= 10:
                    imageView.image = UIImage(named: "ic_star_full")
                default:
                    break
                }
            }
        }
    }
}
