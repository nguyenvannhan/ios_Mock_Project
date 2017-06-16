//
//  CommonReportCell.swift
//  Mock_Revenue
//
//  Created by vannhan on 6/16/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import UIKit

class CommonReportCell: UICollectionViewCell {
    
    @IBOutlet weak var lbTotalExpense: UILabel!
    @IBOutlet weak var lbTotalIncome: UILabel!
    @IBOutlet weak var lbTotalBanlance: UILabel!
    @IBOutlet weak var lbName: UILabel!
    
    func configure(totalExpense: String, totalIncome: String, totalBalance: String, name: String) {
        self.lbName.text = name
        self.lbTotalIncome.text = totalIncome
        self.lbTotalExpense.text = totalExpense
        self.lbTotalBanlance.text = totalBalance
    }
    
    func configure(model: CommonReportModel) {
        self.lbName.text = model.name
        self.lbTotalIncome.text = model.totalIncome! + " VNĐ"
        self.lbTotalExpense.text = model.totalExpense! + " VNĐ"
        self.lbTotalBanlance.text = model.totalBalance! + " VNĐ"
        
    }
}
