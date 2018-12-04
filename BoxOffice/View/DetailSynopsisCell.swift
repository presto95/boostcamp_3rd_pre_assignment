//
//  DetailSynopsisCell.swift
//  BoxOffice
//
//  Created by Presto on 04/12/2018.
//  Copyright © 2018 presto. All rights reserved.
//

import UIKit

class DetailSynopsisCell: UITableViewCell {

    @IBOutlet weak var synopsisLabel: UILabel! {
        didSet {
            synopsisLabel.text = nil
        }
    }
    
    func setProperties(_ synopsis: String?) {
        synopsisLabel.text = synopsis
    }
}
