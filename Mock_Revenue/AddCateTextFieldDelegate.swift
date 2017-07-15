//
//  AddCateTextFieldDelegate.swift
//  Mock_Revenue
//
//  Created by Nguyễn Văn Nhàn on 7/13/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import Foundation
import UIKit

//Extension for MainViewController class
// To configure Datasource and delegate
extension AddNewCateController: UITextFieldDelegate {
    //dismiss keyboard when press return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    //Dismiss keyboard when touch background
    @IBAction func userTappedBackground(_ sender: Any) {
        self.view.endEditing(true)
    }
}
