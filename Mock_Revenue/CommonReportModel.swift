//
//  CommonReportModel.swift
//  Mock_Revenue
//
//  Created by vannhan on 6/16/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import Foundation

class CommonReportModel {
    var name: String?
    var totalIncome: String?
    var totalExpense: String?
    var totalBalance: String?
    
    init(name: String?, totalIncome: String?, totalExpense: String?, totalBalance: String?) {
        self.name = name
        self.totalBalance = totalBalance
        self.totalExpense = totalExpense
        self.totalIncome = totalIncome
    }
}
