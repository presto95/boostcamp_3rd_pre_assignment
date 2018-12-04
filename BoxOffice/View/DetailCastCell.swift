//
//  DetailCastCell.swift
//  BoxOffice
//
//  Created by Presto on 04/12/2018.
//  Copyright © 2018 presto. All rights reserved.
//

import UIKit

class DetailCastCell: UITableViewCell {

    @IBOutlet weak var directorLabel: UILabel! {
        didSet {
            directorLabel.text = nil
        }
    }
    
    @IBOutlet weak var actorLabel: UILabel! {
        didSet {
            actorLabel.text = nil
        }
    }
    
    func setProperties(director: String, actor: String) {
        directorLabel.text = director
        actorLabel.text = actor
    }
}
