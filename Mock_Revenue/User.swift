//
//  User.swift
//  Mock_Revenue
//
//  Created by vannhan on 6/11/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import Foundation

class User {
    static var name: String?
    static var age: Int?
    static var uid: String?
    static var amount: Double?
    static var email: String?
    
    static func setInfo(json: [String: AnyObject]) {
        self.name = json["ten"] as? String
        self.age = json["tuoi"] as? Int
        self.amount = json["luong_tien"] as? Double
    }
    
    static func setInfo(name: String, age: Int, amount: Double) {
        self.name = name
        self.age = age
        self.amount = amount
    }
}
