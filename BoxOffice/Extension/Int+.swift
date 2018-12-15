//
//  Int+.swift
//  BoxOffice
//
//  Created by Presto on 04/12/2018.
//  Copyright © 2018 presto. All rights reserved.
//

import UIKit

extension Int {
    /// 등급 정보에 대한 이미지 반환.
    var toGradeImage: UIImage? {
        if self == 0 {
            return UIImage(named: "ic_allages")
        }
        return UIImage(named: "ic_\(self)")
    }
}
