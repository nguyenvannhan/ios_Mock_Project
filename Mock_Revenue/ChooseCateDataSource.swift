//
//  ChooseCateDataSource.swift
//  Mock_Revenue
//
//  Created by Nguyễn Văn Nhàn on 7/11/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import Foundation
import UIKit

//Extension for ChooseCateController class
// To configure Datasource and delegate
extension ChooseCateController: UITableViewDelegate, UITableViewDataSource {
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
        let cell = self.tblCateList.dequeueReusableCell(withIdentifier: "ChooseCateCell") as! ChooseCateCell
        let revenueType = revenueTypeList[indexPath.row]
        
        cell.configure(revenueType: revenueType)
        
        return cell
    }
    
    // Catch event click a row in tableView
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let revenueType = revenueTypeList[indexPath.row] as RevenueType
        var idType = 0
        
        if !isOutcome {
            idType = 1
        }
        
        //Return value for previous screen
        myDelegate?.returnData(idType: idType, revenueType: revenueType)
        
        //Back to previous screen
        _ = navigationController?.popViewController(animated: true)
    }
    
    //Get data from Firebase
    func getData() {
        //If choose Outcome Type
        if isOutcome {
            daoRevenueType.getOutComeType(completionHandler: { (revenueTypeList, error) in
                if error == nil {
                    self.revenueTypeList = revenueTypeList!
                    
                    DispatchQueue.main.async {
                        self.tblCateList.reloadData()
                    }
                }
            })
        } else { // If choose Income Type
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
