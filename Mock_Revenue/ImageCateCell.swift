//
//  ImageCateCell.swift
//  Mock_Revenue
//
//  Created by vannhan on 6/11/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import UIKit

class ImageCateCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    
    let commonFunction: CommonFunction = CommonFunction()
    
    func configure(image: String) {
        self.imgView.image = commonFunction.resizeImage(image: UIImage(named: image)!, targetSize:CGSize(width: 60, height: 60))
    }
}
