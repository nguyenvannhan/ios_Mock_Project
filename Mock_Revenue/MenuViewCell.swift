//
//  MenuViewCell.swift
//  Mock_Revenue
//
//  Created by vannhan on 6/10/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import UIKit

class MenuViewCell: UITableViewCell {

    @IBOutlet weak var lbMenuCellName: UILabel!
    @IBOutlet weak var imgMenuCell: UIImageView!
    
    let commonFunction: CommonFunction = CommonFunction()
    
    func configureCell(img: UIImage?, lbMenuName: String?) {
        self.imgMenuCell.image = commonFunction.resizeImage(image: img!, targetSize: CGSize(width: 30, height: 30))
        self.lbMenuCellName.text = lbMenuName
    }
    
    func configureCell(menu: Menu) {
        self.imageView?.image = commonFunction.resizeImage(image: menu.image!	, targetSize: CGSize(width: 30, height: 30))
        self.lbMenuCellName.text = menu.name
    }

}
