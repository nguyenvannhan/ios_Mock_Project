//
//  CateViewCell.swift
//  Mock_Revenue
//
//  Created by vannhan on 6/10/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import UIKit

class CateViewCell: UITableViewCell {

    @IBOutlet weak var lbNameCate: UILabel!
    @IBOutlet weak var imgCate: UIImageView!
    
    func configure(typeRevenue: RevenueType) {
        self.lbNameCate.text = typeRevenue.name
        self.imgCate.image = UIImage(named: typeRevenue.image!)
    }

}
