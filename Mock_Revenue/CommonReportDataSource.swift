//
//  CommonReportDataSource.swift
//  Mock_Revenue
//
//  Created by Nguyễn Văn Nhàn on 7/11/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import Foundation
import UIKit

//Extension for MainViewController class
// To configure Datasource and delegate
extension CommonReportController: UICollectionViewDelegate, UICollectionViewDataSource {
    // Number Of Section
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //Number of Items in each Section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reportList.count
    }
    
    //Format Cell to display on Item
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reportModel = reportList[indexPath.row]
        
        let cell = self.reportCollectionView.dequeueReusableCell(withReuseIdentifier: "CommonReportCell", for: indexPath) as! CommonReportCell
        
        cell.configure(model: reportModel)
        
        return cell
    }
    
    //Get data from Firebase
    func getData() {
        let daoReport: DAOReport = DAOReport()
        
        KRActivityIn.startActivityIndicator(uiView: self.view)
        
        daoReport.getDataList(completionHandler: { (reportList, error) in
            if error == nil {
                self.reportList = reportList!
                DispatchQueue.main.async {
                    self.reportCollectionView.reloadData()
                    KRActivityIn.stopActivityIndicator()
                }
            } else {
                KRActivityIn.stopActivityIndicator()
            }
        })
    }
}
