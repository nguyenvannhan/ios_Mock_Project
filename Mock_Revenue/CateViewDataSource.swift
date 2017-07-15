//
//  CateViewDataSource.swift
//  Mock_Revenue
//
//  Created by Nguyễn Văn Nhàn on 7/11/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import Foundation
import UIKit

//Extension for CateViewController class
// To configure Datasource and delegate
extension CateViewController: UITableViewDelegate, UITableViewDataSource {
    // Number Of Section
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Number of Rows in each Section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return revenueTypeList.count
    }
    
    //Format Cell to display on Row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let revenueType = revenueTypeList[indexPath.row]
        
        let cell = tblCateList.dequeueReusableCell(withIdentifier: "CateViewCell") as! CateViewCell
        
        // Configure the cell...
        cell.configure(typeRevenue: revenueType)
        
        return cell
    }
    
    //Get data from Firebase
    func getData() {
        KRActivityIn.startActivityIndicator(uiView: self.view)
        if isOutcome {
            daoRevenueType.getOutComeType(completionHandler: { (revenueTypeList, error) in
                if error == nil {
                    self.revenueTypeList = []
                    self.revenueTypeList = revenueTypeList!
                    
                    DispatchQueue.main.async {
                        KRActivityIn.stopActivityIndicator()
                        self.tblCateList.reloadData()
                    }
                }
            })
        } else {
            daoRevenueType.getInComeType(completionHandler: { (revenueTypeList, error) in
                if error == nil {
                    self.revenueTypeList = []
                    self.revenueTypeList = revenueTypeList!
                    
                    DispatchQueue.main.async {
                        KRActivityIn.stopActivityIndicator()
                        self.tblCateList.reloadData()
                    }
                }
            })
        }
    }
}
