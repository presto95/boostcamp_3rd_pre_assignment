//
//  DetailCommentCell.swift
//  BoxOffice
//
//  Created by Presto on 04/12/2018.
//  Copyright © 2018 presto. All rights reserved.
//

import UIKit

class DetailCommentCell: UITableViewCell {

    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        return formatter
    }()
    
    @IBOutlet private weak var commentLabel: UILabel!
    
    @IBOutlet private weak var composeButton: UIButton!
    
    @IBOutlet private weak var userImageView: UIImageView!
    
    @IBOutlet private weak var writerLabel: UILabel! {
        didSet {
            writerLabel.text = nil
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
    
    @IBOutlet private weak var timestampLabel: UILabel! {
        didSet {
            timestampLabel.text = nil
        }
    }
    
    @IBOutlet private weak var contentsLabel: UILabel! {
        didSet {
            contentsLabel.text = nil
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        commentLabel.text = "한줄평"
        composeButton.isHidden = false
    }

    func setProperties(_ object: Comment.Data, at row: Int) {
        if row != 0 {
            commentLabel.text = nil
            composeButton.isHidden = true
        }
        writerLabel.text = object.writer
        timestampLabel.text = dateFormatter.string(from: Date(timeIntervalSince1970: object.timestamp))
        contentsLabel.text = object.contents
        setRatingStackView(rating: object.rating)
    }
    
    private func setRatingStackView(rating value: Double) {
        for (index, view) in ratingStackView.arrangedSubviews.enumerated() {
            if let imageView = view as? UIImageView {
                let unit = Double(index * 2)
                if value >= unit + 2 {
                    imageView.image = UIImage(named: "ic_star_large_full")
                } else if value >= unit + 1 {
                    imageView.image = UIImage(named: "ic_star_large_half")
                } else {
                    imageView.image = UIImage(named: "ic_star_large")
                } 
            }
        }
    }
}
