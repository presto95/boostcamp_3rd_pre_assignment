//
//  DetailCastCell.swift
//  BoxOffice
//
//  Created by Presto on 04/12/2018.
//  Copyright © 2018 presto. All rights reserved.
//

import UIKit

class DetailCastCell: UITableViewCell {

    @IBOutlet private weak var directorLabel: UILabel! {
        didSet {
            directorLabel.text = nil
        }
    }
    
    @IBOutlet private weak var actorLabel: UILabel! {
        didSet {
            actorLabel.text = nil
        }
    }
    
    func setProperties(director: String, actor: String) {
        directorLabel.text = director
        actorLabel.text = actor
    }
}
