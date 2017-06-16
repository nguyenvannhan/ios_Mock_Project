//
//  ChooseCateCell.swift
//  Mock_Revenue
//
//  Created by vannhan on 6/15/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import UIKit

class ChooseCateCell: UITableViewCell {
    
    @IBOutlet weak var imgCate: UIImageView!
    @IBOutlet weak var lbNameCate: UILabel!
    
    func configure(revenueType: RevenueType) {
        self.imgCate.image = UIImage(named: revenueType.image!)
        self.lbNameCate.text = revenueType.name
    }
}
