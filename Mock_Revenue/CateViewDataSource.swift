//
//  CateViewDataSource.swift
//  Mock_Revenue
//
//  Created by Nguyễn Văn Nhàn on 7/11/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import Foundation
import UIKit

extension CateViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return revenueTypeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let revenueType = revenueTypeList[indexPath.row]
        
        let cell = tblCateList.dequeueReusableCell(withIdentifier: "CateViewCell") as! CateViewCell
        
        cell.configure(typeRevenue: revenueType)
        
        return cell
    }
    
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
