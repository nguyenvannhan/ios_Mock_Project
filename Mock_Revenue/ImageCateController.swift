//
//  ImageCateController.swift
//  Mock_Revenue
//
//  Created by vannhan on 6/11/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import UIKit



class ImageCateController: UIViewController {

    @IBOutlet var imageCollectionView: UICollectionView!
    
    var imageList: [String] = []
    let commonFunction: CommonFunction = CommonFunction()
    var myDelegate: SendImageBack?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageCollectionView.delegate = self
        self.imageCollectionView.dataSource = self
        
        imageList = commonFunction.readImageFromPlist()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UICollectionViewDataSource

}
