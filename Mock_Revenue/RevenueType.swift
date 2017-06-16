//
//  RevenueType.swift
//  Mock_Revenue
//
//  Created by vannhan on 6/10/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import Foundation

//
//  Type_Revenue.swift
//  Mock_Revenue
//
//  Created by vannhan on 6/7/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import Foundation

class RevenueType {
    var key: String?
    var name: String?
    var image: String?
    
    init(name: String?, image: String) {
        self.name = name
        self.image = image
    }
    
    init(json: [String: AnyObject]) {
        self.name = json["ten"] as? String
        self.image = json["hinh_anh"] as? String
    }
}
