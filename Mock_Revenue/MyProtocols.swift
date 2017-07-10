//
//  MyProtocols.swift
//  Mock_Revenue
//
//  Created by Nguyễn Văn Nhàn on 7/8/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import Foundation

protocol KeyboardDelegate: class {
    func keyWasTapped(character: String)
    
    func updateKeyboard(tag: Int)
}

protocol SetValuePreviousVC {
    func returnData(idType: Int?, revenueType: RevenueType?)
}

protocol SendImageBack {
    func setValueImage(image: String)
}
