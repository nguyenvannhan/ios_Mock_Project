//
//  LoginTextFieldDelegate.swift
//  Mock_Revenue
//
//  Created by Nguyễn Văn Nhàn on 7/13/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import Foundation
import UIKit

//Extension for LoginController class
// To configure Datasource and delegate
extension LoginController: UITextFieldDelegate {
    //function dismiss keyboard when press return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //function dismiss keyboard when touch background
    @IBAction func userTappedBackground(_ sender: Any) {
        self.view.endEditing(true)
    }
}
