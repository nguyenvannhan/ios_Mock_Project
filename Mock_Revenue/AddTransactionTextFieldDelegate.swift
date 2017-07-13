//
//  AddTransactionTextFieldDelegate.swift
//  Mock_Revenue
//
//  Created by Nguyễn Văn Nhàn on 7/13/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import Foundation
import UIKit

extension AddTransactionController: UITextFieldDelegate, UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func userTappedBackground() {
        self.myScrollView.endEditing(true)
    }
}
