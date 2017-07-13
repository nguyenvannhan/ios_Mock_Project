//
//  RegisterViewTextFieldDelegate.swift
//  Mock_Revenue
//
//  Created by Nguyễn Văn Nhàn on 7/13/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import Foundation
import UIKit

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func userTappedBackground() {
        self.myScrollView.endEditing(true)
    }
}
