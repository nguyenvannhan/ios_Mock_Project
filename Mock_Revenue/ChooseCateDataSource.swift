//
//  ChooseCateDataSource.swift
//  Mock_Revenue
//
//  Created by Nguyễn Văn Nhàn on 7/11/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import Foundation
import UIKit

extension ChooseCateController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return revenueTypeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblCateList.dequeueReusableCell(withIdentifier: "ChooseCateCell") as! ChooseCateCell
        let revenueType = revenueTypeList[indexPath.row]
        
        cell.configure(revenueType: revenueType)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let revenueType = revenueTypeList[indexPath.row] as RevenueType
        var idType = 0
        
        if !isOutcome {
            idType = 1
        }
        
        myDelegate?.returnData(idType: idType, revenueType: revenueType)
        
        _ = navigationController?.popViewController(animated: true)
    }
    func getData() {
        if isOutcome {
            daoRevenueType.getOutComeType(completionHandler: { (revenueTypeList, error) in
                if error == nil {
                    self.revenueTypeList = revenueTypeList!
                    
                    DispatchQueue.main.async {
                        self.tblCateList.reloadData()
                    }
                }
            })
        } else {
            daoRevenueType.getInComeType(completionHandler: { (revenueTypeList, error) in
                if error == nil {
                    self.revenueTypeList = revenueTypeList!
                    
                    DispatchQueue.main.async {
                        self.tblCateList.reloadData()
                    }
                }
            })
        }
    }
}
