//
//  CommonReportDataSource.swift
//  Mock_Revenue
//
//  Created by Nguyễn Văn Nhàn on 7/11/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import Foundation
import UIKit

extension CommonReportController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reportList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reportModel = reportList[indexPath.row]
        
        let cell = self.reportCollectionView.dequeueReusableCell(withReuseIdentifier: "CommonReportCell", for: indexPath) as! CommonReportCell
        
        cell.configure(model: reportModel)
        
        return cell
    }
    
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
