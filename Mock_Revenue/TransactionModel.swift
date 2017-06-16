//
//  TransactionModel.swift
//  Mock_Revenue
//
//  Created by vannhan on 6/15/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import Foundation

class TransactionModel {
    var imageType: String?
    var nameType: String?
    var idType: Int?
    var note: String?
    var amount: Double?
    var date: String?
    var key: String?
    
    init(imageType: String?, nameType: String?, idType: Int?, note: String, amount: Double?, date: String?) {
        self.imageType = imageType
        self.nameType = nameType
        self.idType = idType
        self.note = note
        self.amount = amount
        self.date = date
    }
    
    init(json: [String: AnyObject]) {
        self.idType = json["ma_loai"] as? Int
        self.imageType = json["anh_loai"] as? String
        self.nameType = json["ten_loai"] as? String
        self.note = json["dien_giai"] as? String
        self.amount = json["so_tien"] as? Double
        self.date = json["ngay"] as? String
    }
}
