//
//  EditTransactionTextFieldDelegate.swift
//  Mock_Revenue
//
//  Created by Nguyễn Văn Nhàn on 7/13/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import Foundation
import UIKit

//Extension for EditTransactionViewController class
// To configure Datasource and delegate
extension EditTransactionViewController: UITextFieldDelegate, UITextViewDelegate {
    
    //Dismiss keyboard when press return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    //Dismiss keyboard when press return key for Text View
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    //Vaidate textfield. User only enter number
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return commonFunction.textFieldValidate(textField: textField, range: range, string: string)
    }
    
    //Dismiss keyboard when touch background
    func userTappedBackground() {
        self.myScrollView.endEditing(true)
    }
}
