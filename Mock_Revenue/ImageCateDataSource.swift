//
//  ImageCateDataSource.swift
//  Mock_Revenue
//
//  Created by Nguyễn Văn Nhàn on 7/11/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import Foundation
import UIKit

extension ImageCateController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCateCell", for: indexPath) as! ImageCateCell
        
        // Configure the cell
        cell.configure(image: imageList[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = self.imageList[indexPath.row] as String
        
        myDelegate?.setValueImage(image: image)
        
        _ = navigationController?.popViewController(animated: true)
    }
}
