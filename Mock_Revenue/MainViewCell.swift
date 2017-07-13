//
//  MainViewCell.swift
//  Mock_Revenue
//
//  Created by vannhan on 6/15/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import UIKit

class MainViewCell: UITableViewCell {

    @IBOutlet weak var imgCate: UIImageView!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbNameCate: UILabel!
    @IBOutlet weak var lbAmount: UILabel!
    @IBOutlet weak var lbNote: UILabel!
    
    func configureCell(transactionM: TransactionModel) {
        let commonFunction: CommonFunction = CommonFunction()
        
        self.imgCate.image = UIImage(named: transactionM.imageType!)
        self.lbDate.text = transactionM.date
        self.lbNameCate.text = "Loại: " + transactionM.nameType!
        self.lbAmount.text = commonFunction.addDotText(text: String(format: "%.0f", transactionM.amount!)) + " VNĐ"
        self.lbNote.text = transactionM.note
        
        if transactionM.idType == 0 {
            self.lbAmount.textColor = UIColor.red
        } else {
            self.lbAmount.textColor = UIColor.green
        }
        
    }
}
