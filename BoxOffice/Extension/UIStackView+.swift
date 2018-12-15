//
//  UIStackView+.swift
//  BoxOffice
//
//  Created by Presto on 09/12/2018.
//  Copyright © 2018 presto. All rights reserved.
//

import UIKit

extension UIStackView {
    /// 평점에 따라 별 모양의 평점 뷰 설정.
    ///
    /// - Parameter value: 평점
    func setRating(_ value: Double) {
        for (index, view) in arrangedSubviews.enumerated() {
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
