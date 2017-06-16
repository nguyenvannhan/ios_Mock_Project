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
    static var age: String?
    static var uid: String?
    static var amount: Double?
    static var email: String?
    
    static func setInfo(json: [String: AnyObject]) {
        self.name = json["ten"] as? String
        self.age = json["tuoi"] as? String
        self.amount = json["luong_tien"] as? Double
    }
}
