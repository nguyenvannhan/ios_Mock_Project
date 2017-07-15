//
//  RegisterViewTextFieldDelegate.swift
//  Mock_Revenue
//
//  Created by Nguyễn Văn Nhàn on 7/13/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import Foundation
import UIKit

//Extension for RegisterViewController class
// To configure Datasource and delegate
extension RegisterViewController: UITextFieldDelegate {
    // function dismiss keyboard when press return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    //function validate textfield, user only enter number
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return commonFunction.textFieldValidate(textField: textField, range: range, string: string)
    }
    
    //function dismiss keyboard when touch background
    func userTappedBackground() {
        self.myScrollView.endEditing(true)
    }
}
