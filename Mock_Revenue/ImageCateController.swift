//
//  ImageCateController.swift
//  Mock_Revenue
//
//  Created by vannhan on 6/11/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import UIKit

protocol SendImageBack {
    func setValueImage(image: String)
}

class ImageCateController: UICollectionViewController {

    var imageList: [String] = []
    
    let commonFunction: CommonFunction = CommonFunction()
    var myDelegate: SendImageBack?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageList = commonFunction.readImageFromPlist()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return imageList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCateCell", for: indexPath) as! ImageCateCell
        
        // Configure the cell
        cell.configure(image: imageList[indexPath.row])
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = self.imageList[indexPath.row] as String
        
        myDelegate?.setValueImage(image: image)
        
        _ = navigationController?.popViewController(animated: true)
    }

}
