//
//  ValidationTextField.swift
//  Mock_Revenue
//
//  Created by vannhan on 6/10/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import Foundation
import AMPopTip

class ValidationTextField: UITextField {
    
    var error = false
    var message = ""
    var image = UIImageView()
    var popTip = PopTip()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        popTip.shouldDismissOnTap = true
        
        let size = self.frame.height
        image.isHidden = true
        image.frame = CGRect.init(x: 0, y: 0, width: size - 8, height: size - 8)
        image.image = UIImage(named: "error_icon")
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(sender:))))
        
        self.rightView = image
        self.rightViewMode = .always
    }
    
    func imageTapped(sender: AnyObject?) {
        popTip.show(text: message, direction: .up, maxWidth: 300, in: self.superview!, from: self.frame)
    }
    
    func setError(error: Bool, message: String = "") {
        self.error = error
        self.message = message
        
        if error {
            image.isHidden = false
            self.layer.borderColor = UIColor.red.cgColor
            self.layer.borderWidth = 1
            popTip.show(text: message, direction: .up, maxWidth: 300, in: self.superview!, from: self.frame)
        } else {
            image.isHidden = true
            self.layer.borderWidth = 0
            popTip.hide()
        }
    }
}
